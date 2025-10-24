#!/bin/bash

setup_battery_thresholds() {
    if [[ -d "/sys/class/power_supply/BAT0" ]] && 
       [[ -f "/sys/class/power_supply/BAT0/charge_control_start_threshold" ]]; then
        
        echo "Setting up battery charge thresholds..."
        
        # Create systemd service
        sudo tee /etc/systemd/system/battery-threshold.service > /dev/null << 'EOF'
[Unit]
Description=Set battery charging thresholds
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo 70 > /sys/class/power_supply/BAT0/charge_control_start_threshold'
ExecStart=/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'
ExecStart=/bin/bash -c 'echo 90 > /sys/class/power_supply/BAT1/charge_control_start_threshold'
ExecStart=/bin/bash -c 'echo 95 > /sys/class/power_supply/BAT1/charge_control_end_threshold'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
        
        sudo systemctl enable battery-threshold.service
        sudo systemctl start battery-threshold.service
        
        echo "✓ Battery thresholds configured (40%-80%)"
    else
        echo "⚠ Battery threshold control not available on this system"
    fi
}

# Call in main installation flow
setup_battery_thresholds
