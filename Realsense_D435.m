    % 导入库文件
    import realsense.*  
    % Make Pipeline object to manage streaming
    pipe = realsense.pipeline();
    % Make Colorizer object to prettify depth output
    colorizer = realsense.colorizer();
    
    % 自定义相机配置
    cfg = realsense.config();
    % cfg.enable_stream(realsense.stream.color);
    % cfg.enable_device('908412110996');
    % cfg.enable_stream(realsense.stream.accel);
    % cfg.enable_stream(realsense.stream.gyro);
    cfg.enable_stream(realsense.stream.color,1280,720,realsense.format.rgb8,15);    
    cfg.enable_stream(realsense.stream.depth,1280,720,realsense.format.z16,6);   
    % Start streaming on an arbitrary camera with 自定义 settings
    % cfg.enable_all_streams();
    
    profile = pipe.start(cfg);
    
    dev=profile.get_device();
    depth_scale = dev.first('depth_sensor').get_depth_scale();
    align_to = realsense.stream.color;
    align = realsense.align(align_to);
    
    % Get streaming device's name
    %dev = profile.get_device();
    %name = dev.get_info(realsense.camera_info.name);    
    % Get frames. We discard the first couple to allow
    % the camera time to settle
   for i = 1:1:1000
        fs = pipe.wait_for_frames();    
        aligned_frames = align.process(fs);
        
        % Fetch time frame
        pf = fs.first_or_default(realsense.stream.color);
        % Fetch img frame
        img_stream = aligned_frames.get_color_frame();
        %time_stamp = pf.get_timestamp();
        % Select depth frame
        depth = aligned_frames.get_depth_frame(); 

        % Colorize depth frame
        color = colorizer.colorize(depth);
        % Get actual data and convert into a format imshow can use
        % (Color data arrives as [R, G, B, R, G, B, ...] vector)
        data = color.get_data();
        depth_img = permute(reshape(data',[3,color.get_width(),color.get_height()]),[3 2 1]);
        depth_img_cut = imcrop(depth_img, [160 0 1120 720]);
        %for(y=0:color.get_height())
         %   pixel_index=y*color.get_width();
          %  for(x=0:color.get_width())
          x=877;
          y=123;
          pixels_distance1=depth_scale*double(data(y*color.get_width()+x));
           % end
        %end
        % Display depth image        
        subplot(2,1,1);
        imshow(depth_img_cut);
        % Display color image
        img = permute(reshape(img_stream.get_data',[3,img_stream.get_width(),img_stream.get_height()]),[3 2 1]);
        img_cut = imcrop(img, [160 0 1120 720]);
        subplot(2,1,2);
        imshow(img_cut);
        
        save_img_cut = 'C:\Users\user\Desktop\RGB\';
        save_depth_img_cut = 'C:\Users\user\Desktop\shendutu\';
        
           filename = [num2str(i,'%04d'),'.png'];
           path1 = fullfile(save_img_cut,filename);
           path2 = fullfile(save_depth_img_cut,filename);
        imwrite(img_cut,path1,'png');
        imwrite(depth_img_cut,path2,'png');
       
        key = waitforbuttonpress;
        if(key == 1)
            % Stop streaming
            pipe.stop(); 
            break;
        end
 end
  
    