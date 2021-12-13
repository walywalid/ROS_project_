#!/bin/bash

echo 'Starting autonomous driving'

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'roscore';
 roscore; 
 exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Connecting to turtlebot with password to turn on the camera'; 
echo 'Copy Paste the following line:'; 
echo 'roslaunch turtlebot3_autorace_traffic_light_camera turtlebot3_autorace_camera_pi.launch';
sshpass -p 'napelturbot' ssh ubuntu@192.168.0.200; 
exec bash"

sleep 7

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Intrinsic calibration'; 
 export AUTO_IN_CALIB=action; 
 export GAZEBO_MODE=false;
 roslaunch turtlebot3_autorace_traffic_light_camera turtlebot3_autorace_intrinsic_camera_calibration.launch;
 exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Extrinsic calibration'; 
 export AUTO_EX_CALIB=action; 
 roslaunch turtlebot3_autorace_traffic_light_camera turtlebot3_autorace_extrinsic_camera_calibration.launch;
 exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Lane detection'; 
 export AUTO_DT_CALIB=action;
 roslaunch turtlebot3_autorace_traffic_light_detect turtlebot3_autorace_detect_lane.launch;
 exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Controle'; 
 roslaunch turtlebot3_autorace_traffic_light_control turtlebot3_autorace_control_lane.launch;
  exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Connecting to turtlebot with password to launch the bringup';
echo 'Copy Paste the following line:'; 
echo 'roslaunch turtlebot3_bringup turtlebot3_robot.launch';
sshpass -p 'napelturbot' ssh ubuntu@192.168.0.200; 
exec bash"

sleep 7

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Image view camera image';
 rosrun image_view image_view image:=/camera/image;
 exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Image view detect lane image';
 rosrun image_view image_view image:=/detect/image_lane/compressed;
 exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Graphe'
 rqt_graph;
 exec bash"







