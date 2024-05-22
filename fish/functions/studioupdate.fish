function studioupdate
	set output "studioupdate.tar.gz"
	set extract_dir "studioupdate"
	set target_dir "/opt/android-studio"

	# Download the file (studioupdate.tar.gz)
	~/.config/scripts/studioupdate/studioupdate
	
	# Check if the download was successful
	if test -e $output
		# Extract the tar.gz file
		mkdir -p $extract_dir
		tar xzf $output -C $extract_dir
		
		# Check if the extraction was successful
    		if test $status -eq 0
    			ls $extract_dir
    			echo "Extraction successful. Preparing to overwrite $target_dir with extracted files..."
			echo "Requesting sudo permissions to overwrite $target_dir..."
			
			# Check if the target directory exists, remove it if it does
			if test -d $target_dir
			    	echo "$target_dir already exists. Removing it..."
				sudo rm -rf $target_dir
			end
			
			# Move the extracted directory to the target directory
        		sudo mv $extract_dir/android-studio $target_dir
        		
        		# Check if the move was successful
			if test $status -eq 0
				echo "Overwrite successful."

    				# Remove the tar.gz file after extraction
        			rm $output
        			rm -rf $extract_dir
        			echo "Archive removed."
        		else
        			echo "Failed to overwrite $target_dir."
        		end
        	else
        		echo "Extraction failed."
        	end
        else
        	echo "Download failed. File not found."
        end
end
