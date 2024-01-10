#! /bin/bash

readonly macbin_dir="${HOME}/localdev/macbin"
readonly property="com.apple.quarantine"

for file in $(ls "${macbin_dir}") ; do
	real_file="$(realpath "${macbin_dir}/${file}")"
	echo -n "${file}: "
	chmod +x "${real_file}"
	echo -n "added +x bit, "
	if xattr "${real_file}" | grep -q -F "${property}" ; then
		xattr -d "${property}" "${real_file}"
	fi
	echo -n "removed quarantine bit, "
	echo "done"
done
