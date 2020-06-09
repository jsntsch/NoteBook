clear all
    % 导入库文件
    import realsense.*  
    % Make Pipeline object to manage streaming
    pipe = realsense.pipeline();
    % Make Colorizer object to prettify depth output
    %colorizer = realsense.colorizer();
    
    % 自定义相机配置
    cfg = realsense.config();
    % cfg.enable_stream(realsense.stream.color);
    % cfg.enable_device('908412110996');
    % cfg.enable_stream(realsense.stream.accel);
    % cfg.enable_stream(realsense.stream.gyro);
    cfg.enable_stream(realsense.stream.color);    
    % Start streaming on an arbitrary camera with 自定义 settings
    % cfg.enable_all_streams();
    
    profile = pipe.start(cfg);
    % Get streaming device's name
    dev = profile.get_device();
    name = dev.get_info(realsense.camera_info.name);    
    % Get frames. We discard the first couple to allow
    % the camera time to settle
    pause(1);
    for i = 1:1
            
        fs = pipe.wait_for_frames();       
        % Fetch time frame
        pf = fs.first_or_default(realsense.stream.color);
        % Fetch img frame
        img_stream = fs.get_color_frame();
        time_stamp = pf.get_timestamp();
                 
    end  
    % Stop streaming
    pipe.stop();  
    
    % Select depth frame
    %depth = fs.get_depth_frame();
    % Colorize depth frame
    %color = colorizer.colorize(depth);
    % Get actual data and convert into a format imshow can use
    % (Color data arrives as [R, G, B, R, G, B, ...] vector)
    %data = color.get_data();
    %depth_img = permute(reshape(data',[3,color.get_width(),color.get_height()]),[3 2 1]);
    % Display depth image
    %imshow(depth_img);
    
    % Display color image
    img = permute(reshape(img_stream.get_data',[3,img_stream.get_width,img_stream.get_height()]),[3 2 1]);
    imshow(img);
    