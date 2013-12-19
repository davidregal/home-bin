# First update wp/dev/. Test it. Then run this script.

echo "Starting update"
date
for dirWP in /var/www/wp/*; do

    if [ -d "$dirWP" ]; then
        echo "Processing ${dirWP} ..."
        cd "${dirWP}"
        git pull
    fi
done

echo "Update complete"
date
echo "Exiting"
