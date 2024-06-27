- 安装指南

首先安装jittor：

~~~
sudo apt install libomp-dev
python -m pip install jittor
pip install numpy==1.26.4
# 检测是否成功安装
python -m jittor.test.test_example
~~~

项目依赖于cuda运行，因此需要首先编译cuda代码供jittor调用。首先需要设置如下的环境变量用于编译

~~~
export CUDACXX=你的cuda的nvcc路径

cd gaussian_renderer/diff_gaussian_rasterizater
mkdir build && cd build
cmake .. -DCMAKE_CXX_COMPILER=g++ -DCMAKE_CUDA_ARCHITECTURES=86(根据显卡版本选用70.75.86)
make -j4

cd ../../../scene/simple_knn
mkdir build && cd build
cmake ..
make -j4
~~~

编译完毕后，后续可以直接使用jittor引用对应代码。注意选手修改了代码后需要**重新编译**！
为了方便同学们，我们也提供了Dockerfile用于直接提供可运行环境。执行如下代码即可：

~~~
sudo docker build -t comp .
sudo docker image list （查看镜像id）
sudo docker run -it --gpus all --name comp_gs 你的镜像id
sudo docker ps -a （查看容器id）
sudo docker exec -it comp_gs /bin/bash
sudo docker cp xx comp_gs:xx 拷贝文件到容器中
~~~

比赛的最后评测阶段，要求选手提交代码用于复现。如果选手环境难以复现，会要求选手提供Docker镜像用于复现。

- 运行指南

框架的运行指令如下。

训练指令
~~~
python train.py -s path_to_data --eval
~~~

渲染指令
~~~
python render.py -m path_to_output
~~~

最后，选手需要把渲染图片按照渲染得到的名称和顺序组织，放入对应场景名称的文件夹中。把所有文件夹打包压缩包上传。

选手可以根据需求调整代码，但是必须保证输出格式和提交要求一致。比赛不允许选手使用除给定数据以外的其他输入。