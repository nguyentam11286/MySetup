#!/usr/bin/env python

import rospy
import smbus
import time
from sensor_msgs.msg import Imu
from std_msgs.msg import Header
import math

# I2C address
MPU9250_ADDR = 0x68
PWR_MGMT_1 = 0x6B
ACCEL_XOUT_H = 0x3B
GYRO_XOUT_H = 0x43

bus = smbus.SMBus(1)  # Use I2C bus 1

def read_word(reg):
    high = bus.read_byte_data(MPU9250_ADDR, reg)
    low = bus.read_byte_data(MPU9250_ADDR, reg+1)
    value = (high << 8) + low
    return value - 65536 if value > 32767 else value

def init_mpu9250():
    bus.write_byte_data(MPU9250_ADDR, PWR_MGMT_1, 0)  # Wake up sensor

def imu_publisher():
    rospy.init_node('mpu9250_node')
    imu_pub = rospy.Publisher('/imu/data_raw', Imu, queue_size=10)
    rate = rospy.Rate(50)  # 50Hz

    imu_msg = Imu()
    imu_msg.header.frame_id = "imu_link"

    init_mpu9250()
    rospy.loginfo("MPU9250 Initialized")

    while not rospy.is_shutdown():
        now = rospy.Time.now()
        imu_msg.header.stamp = now

        # Accelerometer
        ax = read_word(ACCEL_XOUT_H) / 16384.0
        ay = read_word(ACCEL_XOUT_H + 2) / 16384.0
        az = read_word(ACCEL_XOUT_H + 4) / 16384.0

        # Gyroscope
        gx = read_word(GYRO_XOUT_H) / 131.0 * math.pi / 180.0
        gy = read_word(GYRO_XOUT_H + 2) / 131.0 * math.pi / 180.0
        gz = read_word(GYRO_XOUT_H + 4) / 131.0 * math.pi / 180.0

        imu_msg.linear_acceleration.x = ax
        imu_msg.linear_acceleration.y = ay
        imu_msg.linear_acceleration.z = az

        imu_msg.angular_velocity.x = gx
        imu_msg.angular_velocity.y = gy
        imu_msg.angular_velocity.z = gz

        imu_pub.publish(imu_msg)
        rate.sleep()

if __name__ == '__main__':
    try:
        imu_publisher()
    except rospy.ROSInterruptException:
        pass
