---
layout: post
title:  Tensorflow Object detection 教程
date:   2019-04-22 14:31:06
categories: 深度学习
tags: Deeplearning
---


## 环境准备

- Ubuntu 18.04

- conda

- git

  

### conda 创建python3环境

```shell
conda create -n deeplearning python=3.6
source activate deeplearning
```

### conda 安装tensorflow

```shell 
conda install -c conda-forge tensorflow
```

### 系统依赖安装(注意补充)

```shell
apt-get install protobuf-compiler
```

### 项目准备

设定代码目录为 ` /data/deeplearning`

```shell
cd /data/deeplearning
git clone https://github.com/tensorflow/models.git
# 编译protobuf
cd models/research
protoc object_detection/protos/*.proto --python_out=.
# 添加环境变量
export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim
# 测试环境是否成功
python object_detection/builders/model_builder_test.py
```

如果配置正常则输出

```shell
......................
----------------------------------------------------------------------
Ran 22 tests in 0.086s

OK
```

## 数据准备

### 环境准备

- LabelImg
- [Raccon_dataset](<https://github.com/datitran/raccoon_dataset>)中的 `xml_to_csv.py` `generate_tfrecord.py`



### 数据集转换

设定数据集根目录为 `/data/dataset`,目录下分为`train` 和`test` 两个目录，分别存储labelimg标好的原始数据

### raccon_dataset 准备

```shell
git clone https://github.com/datitran/raccoon_dataset
cd raccoon_dataset
```

#### 将xml数据转换成csv 

*修改xml_to_csv.py  完成内容如下;主要修改了`main`方法，可一次遍历主目录下所有目录*

```python
import os
import glob
import pandas as pd
import xml.etree.ElementTree as ET


def xml_to_csv(path):
    xml_list = []
    for xml_file in glob.glob(path + '/*.xml'):
        tree = ET.parse(xml_file)
        root = tree.getroot()
        for member in root.findall('object'):
            value = (root.find('filename').text,
                     int(root.find('size')[0].text),
                     int(root.find('size')[1].text),
                     member[0].text,
                     int(member[4][0].text),
                     int(member[4][1].text),
                     int(member[4][2].text),
                     int(member[4][3].text)
                     )
            xml_list.append(value)
    column_name = ['filename', 'width', 'height', 'class', 'xmin', 'ymin', 'xmax', 'ymax']
    xml_df = pd.DataFrame(xml_list, columns=column_name)
    return xml_df


def main():
    for direcory in ['train','test']:
        image_path = os.path.join('/data/dataset', direcory)
        xml_df = xml_to_csv(image_path)
        xml_df.to_csv('/data/dataset/{0}_labels.csv'.format(direcory), index=None)
    print('Successfully converted xml to csv.')

main()
```

运行后将会在`/data/dataset` 目录生成 `train_labels.csv`和`test_labels.csv`

#### 将csv文件转换成tfrecord

注意修改`generate_tfrecord.py`的`class_text_to_int` 方法，根据自己的标签对应到分类上。这个都要与训练中的`.pbtxt`文件一致

```python
def class_text_to_int(row_label):
    if row_label == 'a1':
        return 1
    else:
        return 2
```

转换文件

```shell
python generate_tfrecord.py --csv_input=/data/dataset/test_labels.csv --output_path=/data/dataset/test.record
python generate_tfrecord.py --csv_input=/data/dataset/train_labels.csv --output_path=/data/dataset/train.record

```



## 训练自己的模型

设定配置文件目录为  `/data/conf`

#### 下载 ssd-mobilenet



```shell
cd /data/conf
wget http://download.tensorflow.org/models/object_detection/ssd_mobilenet_v2_coco_2018_03_29.tar.gz
tar zxvf ssd_mobilenet_v2_coco_2018_03_29.tar.gz

```

#### 修改pipeline.config

```shell
 num_classes: 2  # 第3行，有几个分类就设置为几
 
 fine_tune_checkpoint：/data/conf/ssd_mobilenet_v2_coco_2018_03_29/model.ckpt # 158行为ssd_mobilenet预训练权重
 
 train_input_reader {
  label_map_path: "/data/conf/clickv2_label_map.pbtxt"
  tf_record_input_reader {
    input_path: "/data/dataset/train.record"
  }
}

eval_input_reader {
  label_map_path: "/data/conf/clickv2_label_map.pbtxt"
  shuffle: false
  num_readers: 1
  tf_record_input_reader {
    input_path: "/data/dataset/test.record"
  }
}

```

`fine_tune_checkpoint` 下面一行的 `num_steps` 可以不用配置，在训练时可以指定

#### 配置 label_map.pbtxt

每个分类对应的编号和标签名称 `/data/conf/clickv2_label_map.pbtxt` 写入如下内容

```shell
item {
  id: 1
  name: 'a1'
}

item {
  id: 2
  name: 'a2'
}

```

### 训练模型

```shell
cd  /data/deeplearning/models/research
python object_detection/model_main.py 
　　--pipeline_config_path=/data/conf/ssd_mobilenet_v2_coco_2018_03_29/pipeline.config 
　　--model_dir=/data/models
　　--num_train_steps=50000 
　　--num_eval_steps=2000 
　　--alsologtostderr

```

根据自己需要修改`num_train_steps` 训练次数和`num_eval_steps`每多少次进行一次验证

#### 通过tensorboard对过程进行监控

```shell
tensorboard --logdir=/data/models

```

在浏览器中输入`127.0.0.1:6006`观察训练的过程。

