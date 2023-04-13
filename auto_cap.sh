#! /bin/bash
parameters=$@
added_cap_string=${parameters%docker*}
docker_command=${parameters##*docker}
tmp_cap_path=$(pwd)/cap_list.txt
echo "## Automated Capability Docker run ##"
echo "## Get Capabilities to Temporary txt file"

touch ${tmp_cap_path}
docker_run_options=${docker_command##*run}
if docker run -v ${tmp_cap_path}:/root/cap_list.txt --rm ${docker_run_options} sh -c 'apk add -U libcap; capsh --print > /root/cap_list.txt'; then 
    echo success
else 
    docker run -v ${tmp_cap_path}:/root/cap_list.txt --rm ${docker_run_options} sh -c 'apt-get update; apt-get install libcap2-bin; capsh --print > /root/cap_list.txt'
fi
line=$(head -n 1 ${tmp_cap_path})
cap_string=${line##*=}
cap_array=(`echo $cap_string | sed 's/,/\n/g'`)
unset "cap_array[${#cap_array[@]}-1]"
added_cap_array=(`echo $added_cap_string | sed 's/,/\n/g'`)
echo "## Add Specified Capabilities"
total_cap_array=(${cap_array[@]} ${added_cap_array[@]})
total_cap_array=(${total_cap_array[@]} "SYS_CHROOT")
total_cap_array=( "${total_cap_array[@]/#/--cap-add=}" )
total_cap_string="$(IFS=,; echo "${total_cap_array[@]}")"
echo ${total_cap_string}
echo "## Docker ReRun with Capabilities"
docker run --cap-drop all ${total_cap_string} ${docker_run_options}
echo "## Delete Capability file"
rm -rf ${tmp_cap_path}
exit