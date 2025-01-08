
    # Determine SAS or SATA
    is_sas=""
    if [[ "$drive_type" =~ "SAS" ]]; then
        is_sas="SAS"
    fi

    # Print the SMART details for the drive without headers
    printf "%-15s | %-23s | %-12s | %-18s | %-21s | %-17s | %-3s\n" "$drive" "$serial_number" "$smart_status" "$power_on_hours" "$temperature" "$defect_list_count" "$is_sas"
}

# Print the table header
echo "SMART Report for all storage devices"
echo "----------------|-------------------------|--------------|--------------------|----------------------|-------------------|-----"
echo "Drive           | Serial Number           | SMART Status | Power-On Hours     | Temperature          | Defect List Count | SAS"
echo "----------------|-------------------------|--------------|--------------------|----------------------|-------------------|-----"

# Get a list of drives (usually /dev/sdX for Linux systems)
drives=$(lsblk -dn -o NAME,TYPE | awk '$2 == "disk" {print "/dev/" $1}')

# Loop through each drive and check its SMART details
for drive in $drives; do
    check_smart_details $drive
done
