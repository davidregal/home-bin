# First update wp/dev/. Test it. Then run this script.
shopt -s expand_aliases
. ~/.bash_aliases_local
# TODO: Add skip for production sides (e.g. prefixed with 'prod')

leave=0 # 0 = don't exit, 1 = exit
if [ -d "/var/www/wp" ]; then
	echo "Using /var/www"
	dirWPRoot="/var/www/wp"
elif [ -d ~/"www/wp" ]; then
	echo "Using ~/www"
	dirWPRoot=~/"www/wp"
else
	echo "Not found. Exiting"
	leave=1
fi

if [ "$leave" -eq 0 ]; then
	echo "Starting update"
	date
	for dirWP in "${dirWPRoot}"/*; do

		if [ -d "$dirWP" ]; then
			echo "Processing ${dirWP} ..."
			cd "${dirWP}"
			git pull
		fi
	done

	echo "Update complete"
	date
fi

echo "Exiting"
