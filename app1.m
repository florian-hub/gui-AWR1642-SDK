classdef app1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        TabGroup                       matlab.ui.container.TabGroup
        Tab                            matlab.ui.container.Tab
        UIAxes                         matlab.ui.control.UIAxes
        UIAxes_2                       matlab.ui.control.UIAxes
        UIAxes_3                       matlab.ui.control.UIAxes
        Polar                          
        Tab2                           matlab.ui.container.Tab
        UITable                        matlab.ui.control.Table
        EditFieldLabel                 matlab.ui.control.Label
        EditField                      matlab.ui.control.EditField
        EditField_2Label               matlab.ui.control.Label
        EditField_2                    matlab.ui.control.EditField
        EditField_3Label               matlab.ui.control.Label
        EditField_3                    matlab.ui.control.EditField
        Panel2                         matlab.ui.container.Panel
        HeatmapazimuthprofileCheckBox  matlab.ui.control.CheckBox
        RangeprofileCheckBox           matlab.ui.control.CheckBox
        NoiseProfileCheckBox           matlab.ui.control.CheckBox
        AzimuthProfileCheckBox         matlab.ui.control.CheckBox
        StartButton                    matlab.ui.control.Button
        StopButton                     matlab.ui.control.Button
        
    end
    


    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%                   READ DATA                %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&&&&%%%%%%%%%%%%%%%%%%%%%%%%%


% Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
            refreshplot(app);
        end
        
        % Button pushed function: StartButton
        function StopButtonPushed(app, event)
            close all force;
            clear app
            delete(app1)
            
            
            
        end
        
    end
    

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)
            

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1439 729];
            app.UIFigure.Name = 'MATLAB App';

            
            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [530 1 912 733];

            % Create Tab
            app.Tab = uitab(app.TabGroup);
            app.Tab.Title = 'Tab';

            % Create UIAxes
            app.UIAxes = uiaxes(app.Tab);
            title(app.UIAxes, 'Range Profile for zeros doppler')
            xlabel(app.UIAxes, 'range (m)')
            ylabel(app.UIAxes, 'power of range/noise in DB')
            app.UIAxes.Position = [28 383 300 185];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.Tab);
            title(app.UIAxes_2, 'Azimuth heat map')
            xlabel(app.UIAxes_2, 'Azimuth')
            ylabel(app.UIAxes_2, 'Range')
            app.UIAxes_2.Position = [322 77 300 185];

            % Create UIAxes_3
            app.Polar =  polaraxes(app.Tab);
            app.Polar.Title.String = 'Detected Point';
            app.Polar.Position = [0.522 0.57 0.3 0.3];
            

            % Create Tab2
            app.Tab2 = uitab(app.TabGroup);
            app.Tab2.Title = 'Tab2';

            % Create UITable
            app.UITable = uitable(app.Tab2);
            app.UITable.ColumnName = {'Name'; 'Value'};
            app.UITable.RowName = {};
            app.UITable.ColumnSortable = true;
            app.UITable.ColumnEditable = true;
            app.UITable.CellEditCallback = createCallbackFcn(app, @test, true);
            app.UITable.RowStriping = 'off';
            app.UITable.Position = [56 296 406 358];

            % Create EditFieldLabel
            app.EditFieldLabel = uilabel(app.UIFigure);
            app.EditFieldLabel.HorizontalAlignment = 'right';
            app.EditFieldLabel.Position = [90 607 56 22];
            app.EditFieldLabel.Text = 'Port DATA';

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'text');
            app.EditField.Position = [161 607 100 22];

            % Create EditField_2Label
            app.EditField_2Label = uilabel(app.UIFigure);
            app.EditField_2Label.HorizontalAlignment = 'right';
            app.EditField_2Label.Position = [90 575 56 22];
            app.EditField_2Label.Text = 'Port UART';

            % Create EditField_2
            app.EditField_2 = uieditfield(app.UIFigure, 'text');
            app.EditField_2.Position = [161 575 100 22];
            
            % Create EditField_3Label
            app.EditField_3Label = uilabel(app.UIFigure);
            app.EditField_3Label.HorizontalAlignment = 'right';
            app.EditField_3Label.Position = [90 543 56 22];
            app.EditField_3Label.Text = 'fichier .cfg';

            % Create EditField_3
            app.EditField_3 = uieditfield(app.UIFigure, 'text');
            app.EditField_3.Position = [161 543 100 22];

            % Create Panel2
            app.Panel2 = uipanel(app.UIFigure);
            app.Panel2.AutoResizeChildren = 'off';
            app.Panel2.Title = 'Display';
            app.Panel2.Position = [109 355 269 97];

            % Create HeatmapazimuthprofileCheckBox
            app.HeatmapazimuthprofileCheckBox = uicheckbox(app.Panel2);
            app.HeatmapazimuthprofileCheckBox.Text = 'Heat map azimuth profile';
            %app.HeatmapazimuthprofileCheckBox.ValueChangedFcn = createCallbackFcn(app, @refreshplot, true);
            app.HeatmapazimuthprofileCheckBox.Value = true;
            app.HeatmapazimuthprofileCheckBox.Position = [12 8 155 22];

            % Create RangeprofileCheckBox
            app.RangeprofileCheckBox = uicheckbox(app.Panel2);
            app.RangeprofileCheckBox.Text = 'Range profile';
            %app.RangeprofileCheckBox.ValueChangedFcn = createCallbackFcn(app, @refreshplot, true);
            app.RangeprofileCheckBox.Position = [12 38 93 22];
            app.RangeprofileCheckBox.Value = true;

            % Create NoiseProfileCheckBox
            app.NoiseProfileCheckBox = uicheckbox(app.Panel2);
            app.NoiseProfileCheckBox.Text = 'Noise Profile';
            %app.NoiseProfileCheckBox.ValueChangedFcn = createCallbackFcn(app, @refreshplot, true);
            app.NoiseProfileCheckBox.Position = [162 38 90 22];
            app.NoiseProfileCheckBox.Value = true;

            % Create AzimuthProfileCheckBox
            app.AzimuthProfileCheckBox = uicheckbox(app.Panel2);
            app.AzimuthProfileCheckBox.Text = 'AzimuthProfile';
%             app.AzimuthProfileCheckBox.ValueChangedFcn = createCallbackFcn(app, @refreshplot, true);
            app.AzimuthProfileCheckBox.Position = [171 10 99 22];
            app.AzimuthProfileCheckBox.Value = true;

            % Create StartButton
            app.StartButton = uibutton(app.UIFigure, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.Position = [27 184 100 22];
            app.StartButton.Text = 'Start';

            % Create StopButton
            app.StopButton = uibutton(app.UIFigure, 'push');
            app.StopButton.ButtonPushedFcn = createCallbackFcn(app, @StopButtonPushed, true);
            app.StopButton.Position = [280 184 100 22];
            app.StopButton.Text = 'Stop';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
        
        
        % Callback function: BinWidthSlider, ButtonGroup, UITable
        % Button pushed function: startButton
        
        function test(app,event)
            global EditMode
            dataValue = app.UITable.Data.Value
            EditMode=1;
            fprintf("test")
            
        end
        
        function refreshplot(app, event)
            global initialize
            global stop
            global DATA_sphandle 
            global ConfigParameters
            global EditMode
            
            stop = 0
            
            
            
            while 1
                if initialize == 0 || EditMode==1 
                    
                    Config=[]
                    if EditMode ==1
                        Config=app.UITable.Data.Value
                    end
                    delete(instrfind);
                    uartCOM=app.EditField.Value
                    dataCOM=app.EditField_2.Value
                    configFile = app.EditField_3.Value;%"1642config.cfg";
                    [DATA_sphandle,UART_sphandle,ConfigParameters, T] = radarSetup16XX(configFile,uartCOM,dataCOM,EditMode,Config);
                    if EditMode ~=1
                        app.UITable.Data=T;
                    end
                    
                    initialize = 1
                    EditMode = 0
                end


                myInd = 1;

                [dataOk, detObj, rp, rp_x,np,np_x QQ,idx_detected_object] = readAndParseData16XX(DATA_sphandle,ConfigParameters);
                
                if dataOk ~= 0
                    rp_in_DB = 10*log(rp);
                    np_in_DB = 10*log(np);

                    % Store all the data from the radar
                    frame{myInd} = detObj;
                    % Convert to polar coordinates
                    [thetaPolar, ro] = cart2pol(-detObj.x,detObj.y);

                    % Start with a fresh plot
                    cla(app.UIAxes)
                    cla(app.UIAxes_2)
                    cla(app.Polar)
                    hold(app.UIAxes,'on')
                    
                    if app.NoiseProfileCheckBox.Value & app.RangeprofileCheckBox.Value
                        plot(app.UIAxes,rp_x,rp_in_DB,np_x,np_in_DB);   
                    elseif app.RangeprofileCheckBox.Value
                        plot(app.UIAxes,rp_x,rp_in_DB);
                    elseif app.NoiseProfileCheckBox.Value
                        plot(app.UIAxes,np_x,np_in_DB);
                    end
                    
%                     for i=1:1:detObj.numObj
%                         plot(app.UIAxes,detObj.range(i),rp_in_DB(idx_detected_object(i)),'r*');
%                     end
                    
%                     if detObj.numObj~=0
%                         plot(app.UIAxes,detObj.range,rp_in_DB[]);
%                     end
                    

                    %Plot azimuth Heat Map
                    if app.HeatmapazimuthprofileCheckBox.Value
                        NUM_ANGLE_BINS = 64;
                        theta = asind((-NUM_ANGLE_BINS/2+1 : NUM_ANGLE_BINS/2-1)'*(2/NUM_ANGLE_BINS));
                        range = (0:ConfigParameters.numRangeBins-1) * ConfigParameters.rangeIdxToMeters;
                        imagesc(app.UIAxes_2,theta, range, QQ, [0,max(QQ(:))]);
                        set(app.UIAxes_2,'YDir','normal')
                    end

                    %Plot Polar Map

                    if app.AzimuthProfileCheckBox.Value

                     polar = polarscatter(app.Polar,[],[],'filled');
                     polar.RData = ro;
                     polar.ThetaData = thetaPolar;

                    end
                    
                end
                pause(0.03);
            end
            
        end


    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1
            delete(instrfind);
            
            
            global initialize
            global EditMode
            initialize = 0;
            EditMode = 0;
            
            
           
            createComponents(app)
            %refreshplot(app,event,DATA_sphandle,ConfigParameters)

         
            
            
            
            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
                delete(app1)
                
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
