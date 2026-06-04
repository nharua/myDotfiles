#!/usr/bin/env zsh
# =========================================================
# setup_dns.sh - Quick DNS switcher for active NetworkManager interface
# Sourced in .zshrc to expose the 'dns' command
# =========================================================

dns() {
    # Check if nmcli is available
    if ! command -v nmcli >/dev/null 2>&1; then
        echo "❌ nmcli command not found. This script requires NetworkManager."
        return 1
    fi

    # Identify the active connection and device (Wi-Fi or Ethernet)
    local active_conn active_dev
    active_conn=$(nmcli -t -f NAME,DEVICE,TYPE connection show --active | grep -E ":(802-11-wireless|802-3-ethernet)$" | head -n1 | cut -d':' -f1)
    active_dev=$(nmcli -t -f NAME,DEVICE,TYPE connection show --active | grep -E ":(802-11-wireless|802-3-ethernet)$" | head -n1 | cut -d':' -f2)

    if [[ -z "$active_conn" ]]; then
        echo "❌ No active physical connection (Wi-Fi or Ethernet) found!"
        return 1
    fi

    # Display current DNS servers
    echo "🔌 Active Connection: $active_conn ($active_dev)"
    local current_dns
    current_dns=$(nmcli -g ipv4.dns connection show "$active_conn")
    local current_ignore
    current_ignore=$(nmcli -g ipv4.ignore-auto-dns connection show "$active_conn")
    echo "🔍 Current Profile DNS: ${current_dns:-[Auto/DHCP]} (Ignore DHCP: $current_ignore)"
    echo "=========================================="
    echo "What DNS server do you want to use?"
    echo "  a     -> Auto DNS based on DHCP config"
    echo "  myIP  -> Setup specific DNS server(s) (don't depend on DHCP/manual config)"
    echo "=========================================="

    local choice
    read "choice?DNS selection [a/myIP]: "

    if [[ "$choice" == "a" ]]; then
        echo "⚙️  Switching to Auto DNS (DHCP) for '$active_conn'..."
        nmcli connection modify "$active_conn" ipv4.dns ""
        nmcli connection modify "$active_conn" ipv4.ignore-auto-dns no
        
        # Reapply configuration dynamically without breaking the connection
        if nmcli device reapply "$active_dev" >/dev/null 2>&1; then
            echo "✅ DNS successfully configured to Auto (DHCP)!"
        else
            echo "⚠️  Failed to dynamically reapply. Sudo might be required. Retrying with sudo..."
            sudo nmcli device reapply "$active_dev"
        fi
        
    elif [[ "$choice" == "myIP" || -z "$choice" ]]; then
        # Default to a reliable DNS provider or ask for specific IP
        local default_dns="1.1.1.1 8.8.8.8"
        local dns_ip
        read "dns_ip?Enter DNS IP(s) [default: $default_dns]: "
        if [[ -z "$dns_ip" ]]; then
            dns_ip="$default_dns"
        fi

        echo "⚙️  Setting DNS to '$dns_ip' (ignoring DHCP)..."
        nmcli connection modify "$active_conn" ipv4.dns "$dns_ip"
        nmcli connection modify "$active_conn" ipv4.ignore-auto-dns yes

        # Reapply configuration dynamically without breaking the connection
        if nmcli device reapply "$active_dev" >/dev/null 2>&1; then
            echo "✅ DNS successfully set to: $dns_ip"
        else
            echo "⚠️  Failed to dynamically reapply. Sudo might be required. Retrying with sudo..."
            sudo nmcli device reapply "$active_dev"
        fi
        
    else
        # Allow typing an IP address directly (e.g. 1.1.1.1 or 8.8.8.8)
        if [[ "$choice" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]]; then
            echo "⚙️  Setting DNS to '$choice' (ignoring DHCP)..."
            nmcli connection modify "$active_conn" ipv4.dns "$choice"
            nmcli connection modify "$active_conn" ipv4.ignore-auto-dns yes

            # Reapply configuration dynamically
            if nmcli device reapply "$active_dev" >/dev/null 2>&1; then
                echo "✅ DNS successfully set to: $choice"
            else
                echo "⚠️  Failed to dynamically reapply. Sudo might be required. Retrying with sudo..."
                sudo nmcli device reapply "$active_dev"
            fi
        else
            echo "❌ Invalid option: '$choice'"
            return 1
        fi
    fi

    # Print out the new active DNS servers to confirm
    echo ""
    echo "🔍 New Active DNS configuration (waiting 1s for resolver)..."
    sleep 1
    resolvectl dns "$active_dev" 2>/dev/null || nmcli dev show "$active_dev" | grep DNS
}
