function codeupdate
	set url "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"
	set output "codeupdate.tar.gz"
	set extract_dir "codeupdate"
	set target_dir "/opt/VSCode-linux-x64"

	# Download the file with curl following redirects
	echo "Downloading latest stable code build for linux-x64..."
	curl  -L -o $output $url
	
	# Check if the download was successful
	if test -e $output
		echo "Download successful. Extracting the file..."
		
		# Extract the tar.gz file
		mkdir -p $extract_dir
		tar xzf $output -C $extract_dir
		
		# Check if the extraction was successful
    		if test $status -eq 0
    			ls $extract_dir
    			echo "Extraction successful. Preparing to overwrite $target_dir with extracted files..."
			echo "Requesting sudo permissions to overwrite $target_dir..."
			
			# Check if the target directory exists, create it if it doesn't
			if not test -d $target_dir
			    	echo "$target_dir does not exist. Creating it..."
				sudo mkdir -p $target_dir
			end
			
			# Overwrite the target directory with the extracted files
        		sudo cp -rf $extract_dir/VSCode-linux-x64/* $target_dir
        		
        		# Check if the copy was successful
			if test $status -eq 0
				echo "Overwrite successful."

    				# Remove the tar.gz file after extraction
        			rm $output
        			rm -rf $extract_dir
        			echo "Archive removed."
        			
        			# create symbolic link
        			if not test -e /usr/bin/code	
        				echo "link to /usr/bin/code for easy access"
        				sudo ln -s $target_dir/bin/code /usr/bin/code
        			end
        			
        			# create desktop entry
        			if not test -e /usr/share/applications/code.desktop
        				echo "creating desktop entry"
        				echo "
[Desktop Entry]
Name=Visual Studio Code
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=/opt/VSCode-linux-x64/bin/code
Icon=/opt/VSCode-linux-x64/resources/app/resources/linux/code.png
Terminal=false
Type=Application
Categories=TextEditor;Development;IDE;
					" > ~/.local/share/applications/code.desktop
				end
        				
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
