function venv
	if test -d .venv
		source .venv/bin/activate.fish
		echo "activated"
	else
		python -m venv .venv
		source .venv/bin/activate.fish
		echo "created .venv and activated it"
	end
end
