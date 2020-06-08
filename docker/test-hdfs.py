import tensorflow as tf

# tf.io.gfile.makedirs("hdfs://kevin0:8020/user/root/test")
# print(tf.gfile.ListDirectory('hdfs://192.168.103.160:8020/user/root/'))
print(tf.io.gfile.listdir('hdfs://140.116.245.134:9000/user/submarine'))

