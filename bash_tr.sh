
#!/bin/bash

echo 'Starting Traffic light detection'

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

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Trafic light detection';
 export AUTO_DT_CALIB=calibration;
roslaunch turtlebot3_autorace_traffic_light_detect turtlebot3_autorace_detect_traffic_light.launch;
 exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Image view camera image';
 rosrun image_view image_view image:=/detect/image_red_light ;
 rosrun image_view image_view image:=/detect/image_yellow_light ;
 rosrun image_view image_view image:=/detect/image_green_light;
 rosrun image_view image_view image:=/detect/image_traffic_light ;
 exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Traffic light configuration';
 echo 'We have to modify the settings so that on the color channels we see the colors and on the traffic light detection channel we see the words corresponding to the color in question (1. the calibration is very unstable and very subject to light variation; 2. the distance between the traffic light and the camera must be at least 1 meter for an optimal detection)'
 rosrun rqt_reconfigure rqt_reconfigure;
 exec bash"

sleep 2

gnome-terminal --working-directory='/home/mscv_gr1@CO-ROBOT03' --tab -- bash -c "echo 'Graphe'
 rqt_graph;
 exec bash"



