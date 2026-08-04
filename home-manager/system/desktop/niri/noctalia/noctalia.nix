{
  config,
  lib,
  pkgs,
  ...
}:

{

  options.system.desktop.niri.noctalia.enable = lib.mkEnableOption "Enable Noctalia Shell for Niri";

  config =
    lib.mkIf (config.system.desktop.niri.enable && config.system.desktop.niri.noctalia.enable)
      {

        programs.noctalia-shell = {
          enable = true;

          settings = {
            # ===== settings.bar =====
            bar = {
              barType = "simple";
              position = "top";
              monitors = [ "eDP-1" ];
              density = "default";
              showOutline = false;
              showCapsule = false;
              capsuleOpacity = 0;
              capsuleColorKey = "none";
              widgetSpacing = 10;
              contentPadding = 6;
              fontScale = 1;
              enableExclusionZoneInset = true;
              backgroundOpacity = 0.93;
              useSeparateOpacity = false;
              marginVertical = 4;
              marginHorizontal = 4;
              frameThickness = 4;
              frameRadius = 4;
              outerCorners = false;
              hideOnOverview = false;
              displayMode = "always_visible";
              autoHideDelay = 500;
              autoShowDelay = 150;
              showOnWorkspaceSwitch = true;

              widgets = {
                left = [
                  {
                    id = "Workspace";
                    characterCount = 2;
                    colorizeIcons = false;
                    emptyColor = "secondary";
                    enableScrollWheel = true;
                    focusedColor = "primary";
                    followFocusedScreen = false;
                    fontWeight = "bold";
                    groupedBorderOpacity = 1;
                    hideUnoccupied = false;
                    iconScale = 0.8;
                    labelMode = "index";
                    occupiedColor = "secondary";
                    pillSize = 0.6;
                    showApplications = false;
                    showApplicationsHover = false;
                    showBadge = true;
                    showLabelsOnlyWhenOccupied = true;
                    unfocusedIconsOpacity = 1;
                  }
                  {
                    id = "ActiveWindow";
                    colorizeIcons = false;
                    hideMode = "hidden";
                    maxWidth = 145;
                    scrollingMode = "hover";
                    showIcon = true;
                    showText = true;
                    textColor = "none";
                    useFixedWidth = false;
                  }
                ];

                center = [
                  {
                    id = "MediaMini";
                    compactMode = false;
                    hideMode = "hidden";
                    hideWhenIdle = false;
                    maxWidth = 145;
                    panelShowAlbumArt = true;
                    scrollingMode = "hover";
                    showAlbumArt = true;
                    showArtistFirst = true;
                    showProgressRing = true;
                    showVisualizer = false;
                    textColor = "none";
                    useFixedWidth = false;
                    visualizerType = "linear";
                  }
                  {
                    id = "Clock";
                    clockColor = "none";
                    customFont = "";
                    formatHorizontal = "HH:mm ddd, MMM dd";
                    formatVertical = "HH mm - dd MM";
                    tooltipFormat = "HH:mm ddd, MMM dd";
                    useCustomFont = false;
                  }
                  {
                    id = "NotificationHistory";
                    hideWhenZero = false;
                    hideWhenZeroUnread = false;
                    iconColor = "none";
                    showUnreadBadge = true;
                    unreadBadgeColor = "primary";
                  }
                ];

                right = [
                  {
                    id = "Tray";
                    blacklist = [ ];
                    chevronColor = "none";
                    colorizeIcons = false;
                    drawerEnabled = true;
                    hidePassive = false;
                    pinned = [ ];
                  }
                  {
                    id = "Battery";
                    deviceNativePath = "__default__";
                    displayMode = "graphic-clean";
                    hideIfIdle = false;
                    hideIfNotDetected = true;
                    showNoctaliaPerformance = false;
                    showPowerProfiles = false;
                  }
                  {
                    id = "Volume";
                    displayMode = "onhover";
                    iconColor = "none";
                    middleClickCommand = "pwvucontrol || pavucontrol";
                    textColor = "none";
                  }
                  {
                    id = "ControlCenter";
                    colorizeDistroLogo = false;
                    colorizeSystemIcon = "none";
                    colorizeSystemText = "none";
                    customIconPath = "";
                    enableColorization = false;
                    icon = "noctalia";
                    useDistroLogo = false;
                  }
                ];
              };

              mouseWheelAction = "none";
              reverseScroll = false;
              mouseWheelWrap = true;
              middleClickAction = "none";
              middleClickFollowMouse = false;
              middleClickCommand = "";
              rightClickAction = "controlCenter";
              rightClickFollowMouse = true;
              rightClickCommand = "";
              screenOverrides = [ ];
            };

            # ===== settings.general =====
            general = {
              avatarImage = "/home/sia/.face";
              dimmerOpacity = 0.2;
              showScreenCorners = false;
              forceBlackScreenCorners = false;
              scaleRatio = 1;
              radiusRatio = 0.1;
              iRadiusRatio = 0.1;
              boxRadiusRatio = 1;
              screenRadiusRatio = 0;
              animationSpeed = 1;
              animationDisabled = false;
              compactLockScreen = true;
              lockScreenAnimations = false;
              lockOnSuspend = true;
              showSessionButtonsOnLockScreen = true;
              showHibernateOnLockScreen = false;
              enableLockScreenMediaControls = false;
              enableShadows = true;
              enableBlurBehind = true;
              shadowDirection = "bottom_right";
              shadowOffsetX = 2;
              shadowOffsetY = 3;
              language = "";
              allowPanelsOnScreenWithoutBar = true;
              showChangelogOnStartup = true;
              telemetryEnabled = false;
              enableLockScreenCountdown = true;
              lockScreenCountdownDuration = 10000;
              autoStartAuth = false;
              allowPasswordWithFprintd = false;
              clockStyle = "custom";
              clockFormat = "hh\\nmmHH:mm ";
              passwordChars = false;
              lockScreenMonitors = [ ];
              lockScreenBlur = 0;
              lockScreenTint = 0;

              keybinds = {
                keyUp = [
                  "Up"
                  "Ctrl+K"
                ];
                keyDown = [
                  "Down"
                  "Ctrl+J"
                ];
                keyLeft = [
                  "Left"
                  "Ctrl+L"
                ];
                keyRight = [
                  "Right"
                  "Ctrl+H"
                ];
                keyEnter = [
                  "Return"
                  "Enter"
                ];
                keyEscape = [ "Esc" ];
                keyRemove = [ "Del" ];
              };

              reverseScroll = false;
              smoothScrollEnabled = true;
            };

            # ===== settings.ui =====
            ui = {
              fontDefault = "JetBrains Mono Medium";
              fontFixed = "JetBrains Mono ExtraBold";
              fontDefaultScale = 1;
              fontFixedScale = 1;
              tooltipsEnabled = true;
              scrollbarAlwaysVisible = true;
              boxBorderEnabled = false;
              panelBackgroundOpacity = 1;
              translucentWidgets = false;
              panelsAttachedToBar = true;
              settingsPanelMode = "attached";
              settingsPanelSideBarCardStyle = false;
            };

            # ===== settings.location =====
            location = {
              name = "";
              weatherEnabled = true;
              weatherShowEffects = true;
              weatherTaliaMascotAlways = false;
              useFahrenheit = false;
              use12hourFormat = false;
              showWeekNumberInCalendar = false;
              showCalendarEvents = true;
              showCalendarWeather = true;
              analogClockInCalendar = false;
              firstDayOfWeek = -1;
              hideWeatherTimezone = false;
              hideWeatherCityName = false;
              autoLocate = false;
            };

            # ===== settings.calendar =====
            calendar = {
              cards = [
                {
                  enabled = true;
                  id = "calendar-header-card";
                }
                {
                  enabled = true;
                  id = "calendar-month-card";
                }
                {
                  enabled = false;
                  id = "weather-card";
                }
              ];
            };

            # ===== settings.wallpaper =====
            wallpaper = {
              enabled = true;
              overviewEnabled = true;
              directory = "../../../../../assets/";
              monitorDirectories = [ ];
              enableMultiMonitorDirectories = false;
              showHiddenFiles = false;
              viewMode = "single";
              setWallpaperOnAllMonitors = true;
              linkLightAndDarkWallpapers = true;
              fillMode = "crop";
              fillColor = "#000000";
              useSolidColor = false;
              solidColor = "#1a1a2e";
              automationEnabled = false;
              wallpaperChangeMode = "random";
              randomIntervalSec = 300;
              transitionDuration = 1500;
              transitionType = [
                "fade"
                "disc"
                "stripes"
                "wipe"
                "pixelate"
                "honeycomb"
              ];
              skipStartupTransition = false;
              transitionEdgeSmoothness = 0.05;
              panelPosition = "follow_bar";
              hideWallpaperFilenames = false;
              useOriginalImages = false;
              overviewBlur = 0.1;
              overviewTint = 0.6;
              useWallhaven = false;
              wallhavenQuery = "";
              wallhavenSorting = "relevance";
              wallhavenOrder = "desc";
              wallhavenCategories = "111";
              wallhavenPurity = "100";
              wallhavenRatios = "";
              wallhavenApiKey = "";
              wallhavenResolutionMode = "atleast";
              wallhavenResolutionWidth = "";
              wallhavenResolutionHeight = "";
              sortOrder = "name";
              favorites = [ ];
            };

            # ===== settings.appLauncher =====
            appLauncher = {
              enableClipboardHistory = false;
              autoPasteClipboard = false;
              enableClipPreview = true;
              clipboardWrapText = true;
              enableClipboardSmartIcons = true;
              enableClipboardChips = true;
              clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
              clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
              position = "center";
              pinnedApps = [ ];
              sortByMostUsed = true;
              terminalCommand = "alacritty -e";
              customLaunchPrefixEnabled = false;
              customLaunchPrefix = "";
              viewMode = "list";
              showCategories = true;
              iconMode = "tabler";
              showIconBackground = false;
              enableSettingsSearch = true;
              enableWindowsSearch = true;
              enableSessionSearch = true;
              ignoreMouseInput = false;
              screenshotAnnotationTool = "";
              overviewLayer = false;
              density = "default";
            };

            # ===== settings.controlCenter =====
            controlCenter = {
              position = "top_right";
              diskPath = "/";
              shortcuts = {
                left = [
                  { id = "Network"; }
                  { id = "Bluetooth"; }
                  { id = "NoctaliaPerformance"; }
                ];
                right = [
                  { id = "PowerProfile"; }
                  { id = "KeepAwake"; }
                  { id = "NightLight"; }
                ];
              };
              cards = [
                {
                  enabled = true;
                  id = "profile-card";
                }
                {
                  enabled = true;
                  id = "shortcuts-card";
                }
                {
                  enabled = true;
                  id = "audio-card";
                }
                {
                  enabled = true;
                  id = "brightness-card";
                }
                {
                  enabled = false;
                  id = "weather-card";
                }
                {
                  enabled = false;
                  id = "media-sysmon-card";
                }
              ];
            };

            # ===== settings.systemMonitor =====
            systemMonitor = {
              cpuWarningThreshold = 80;
              cpuCriticalThreshold = 90;
              tempWarningThreshold = 80;
              tempCriticalThreshold = 90;
              gpuWarningThreshold = 80;
              gpuCriticalThreshold = 90;
              memWarningThreshold = 80;
              memCriticalThreshold = 90;
              swapWarningThreshold = 80;
              swapCriticalThreshold = 90;
              diskWarningThreshold = 80;
              diskCriticalThreshold = 90;
              diskAvailWarningThreshold = 20;
              diskAvailCriticalThreshold = 10;
              batteryWarningThreshold = 20;
              batteryCriticalThreshold = 5;
              enableDgpuMonitoring = false;
              useCustomColors = false;
              warningColor = "";
              criticalColor = "";
              externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
            };

            # ===== settings.noctaliaPerformance =====
            noctaliaPerformance = {
              disableWallpaper = true;
              disableDesktopWidgets = true;
            };

            # ===== settings.dock =====
            dock = {
              enabled = false;
              position = "right";
              displayMode = "auto_hide";
              dockType = "floating";
              backgroundOpacity = 1;
              floatingRatio = 1;
              size = 1;
              onlySameOutput = true;
              monitors = [ ];
              pinnedApps = [ ];
              colorizeIcons = false;
              showLauncherIcon = false;
              launcherPosition = "end";
              launcherUseDistroLogo = false;
              launcherIcon = "";
              launcherIconColor = "none";
              pinnedStatic = false;
              inactiveIndicators = false;
              groupApps = false;
              groupContextMenuMode = "extended";
              groupClickAction = "cycle";
              groupIndicatorStyle = "dots";
              deadOpacity = 0.6;
              animationSpeed = 1;
              sitOnFrame = false;
              showDockIndicator = false;
              indicatorThickness = 3;
              indicatorColor = "primary";
              indicatorOpacity = 0.6;
            };

            # ===== settings.network =====
            network = {
              bluetoothRssiPollingEnabled = false;
              bluetoothRssiPollIntervalMs = 60000;
              networkPanelView = "wifi";
              wifiDetailsViewMode = "grid";
              bluetoothDetailsViewMode = "grid";
              bluetoothHideUnnamedDevices = false;
              disableDiscoverability = false;
              bluetoothAutoConnect = true;
            };

            # ===== settings.sessionMenu =====
            sessionMenu = {
              enableCountdown = true;
              countdownDuration = 10000;
              position = "center";
              showHeader = true;
              showKeybinds = true;
              largeButtonsStyle = true;
              largeButtonsLayout = "single-row";
              powerOptions = [
                {
                  action = "lock";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "1";
                }
                {
                  action = "suspend";
                  command = "";
                  countdownEnabled = true;
                  enabled = false;
                  keybind = "2";
                }
                {
                  action = "hibernate";
                  command = "";
                  countdownEnabled = true;
                  enabled = false;
                  keybind = "3";
                }
                {
                  action = "reboot";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "4";
                }
                {
                  action = "logout";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "5";
                }
                {
                  action = "shutdown";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "6";
                }
                {
                  action = "rebootToUefi";
                  command = "";
                  countdownEnabled = true;
                  enabled = false;
                  keybind = "7";
                }
                {
                  action = "userspaceReboot";
                  command = "";
                  countdownEnabled = true;
                  enabled = false;
                  keybind = "";
                }
              ];
            };

            # ===== settings.notifications =====
            notifications = {
              enabled = true;
              enableMarkdown = false;
              density = "compact";
              monitors = [ "eDP-1" ];
              location = "top";
              overlayLayer = true;
              backgroundOpacity = 0.8;
              respectExpireTimeout = false;
              lowUrgencyDuration = 3;
              normalUrgencyDuration = 8;
              criticalUrgencyDuration = 15;
              clearDismissed = true;
              saveToHistory = {
                low = true;
                normal = true;
                critical = true;
              };
              sounds = {
                enabled = false;
                volume = 0.5;
                separateSounds = false;
                criticalSoundFile = "";
                normalSoundFile = "";
                lowSoundFile = "";
                excludedApps = "discord,firefox,chrome,chromium,edge";
              };
              enableMediaToast = false;
              enableKeyboardLayoutToast = true;
              enableBatteryToast = true;
            };

            # ===== settings.osd =====
            osd = {
              enabled = true;
              location = "top_right";
              autoHideMs = 2000;
              overlayLayer = true;
              backgroundOpacity = 1;
              enabledTypes = [
                0
                1
                2
              ];
              monitors = [ "eDP-1" ];
            };

            # ===== settings.audio =====
            audio = {
              volumeStep = 5;
              volumeOverdrive = false;
              spectrumFrameRate = 30;
              visualizerType = "linear";
              spectrumMirrored = true;
              mprisBlacklist = [ ];
              preferredPlayer = "";
              volumeFeedback = false;
              volumeFeedbackSoundFile = "";
            };

            # ===== settings.brightness =====
            brightness = {
              brightnessStep = 5;
              enforceMinimum = true;
              enableDdcSupport = false;
              backlightDeviceMappings = [ ];
            };

            # ===== settings.colorSchemes =====
            colorSchemes = {
              useWallpaperColors = false;
              predefinedScheme = "Catppuccin";
              darkMode = true;
              schedulingMode = "off";
              manualSunrise = "06:30";
              manualSunset = "18:30";
              generationMethod = "tonal-spot";
              monitorForColors = "";
              syncGsettings = true;
            };

            # ===== settings.templates =====
            templates = {
              activeTemplates = [ ];
              enableUserTheming = false;
            };

            # ===== settings.nightLight =====
            nightLight = {
              enabled = false;
              forced = false;
              autoSchedule = true;
              nightTemp = "4000";
              dayTemp = "6500";
              manualSunrise = "06:30";
              manualSunset = "18:30";
            };

            # ===== settings.hooks =====
            hooks = {
              enabled = false;
              wallpaperChange = "";
              darkModeChange = "";
              screenLock = "";
              screenUnlock = "";
              performanceModeEnabled = "";
              performanceModeDisabled = "";
              startup = "";
              session = "";
              colorGeneration = "";
            };

            # ===== settings.plugins =====
            plugins = {
              autoUpdate = false;
              notifyUpdates = true;
            };

            # ===== settings.idle =====
            idle = {
              enabled = true;
              screenOffTimeout = 600;
              lockTimeout = 660;
              suspendTimeout = 1800;
              fadeDuration = 5;
              screenOffCommand = "";
              lockCommand = "";
              suspendCommand = "";
              resumeScreenOffCommand = "";
              resumeLockCommand = "";
              resumeSuspendCommand = "";
              customCommands = "[]";
            };

            # ===== settings.desktopWidgets =====
            desktopWidgets = {
              enabled = false;
              overviewEnabled = true;
              gridSnap = false;
              gridSnapScale = false;
              monitorWidgets = [ ];
            };

          };
        };
      };
}
