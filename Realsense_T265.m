clear all
% 导入库文件
import realsense.* 
 
    % Make Pipeline object to manage streaming
    pipe = realsense.pipeline();

    % 自定义相机配置
    cfg = realsense.config();
    cfg.enable_stream(realsense.stream.fisheye, 1);
    cfg.enable_stream(realsense.stream.fisheye, 2);
    % cfg.enable_device('908412110996');
    % cfg.enable_stream(realsense.stream.accel);
    % cfg.enable_stream(realsense.stream.gyro);
    cfg.enable_stream(realsense.stream.pose, realsense.format.six_dof);
    
    % Start streaming on an arbitrary camera with 自定义 settings
    profile = pipe.start(cfg);

    % Get streaming device's name
    dev = profile.get_device();
    name = dev.get_info(realsense.camera_info.name);
    
    % Get frames. We discard the first couple to allow
    % the camera time to settle
    for i = 1:1
        fs = pipe.wait_for_frames();
        
        % Fetch pose frame
        pf = fs.first_or_default(realsense.stream.pose);
        % Fetch pose struct
        pose_data = pf.as('pose_frame').get_pose_data();
        time_stamp = pf.get_timestamp();
        % Fetch fisheye frame
        fisheye_1 = fs.get_fisheye_frame(1);
        fisheye_2 = fs.get_fisheye_frame(2);      
            

    end
   
    % Stop streaming
    pipe.stop();
        
    % Display image
    img_1 = permute(reshape(fisheye_1.get_data',[1,fisheye_1.get_width,fisheye_1.get_height()]),[3 2 1]);
    img_2 = permute(reshape(fisheye_2.get_data',[1,fisheye_2.get_width,fisheye_2.get_height()]),[3 2 1]);    
    img = cat(2, img_1, img_2);
    imshow(img);
    