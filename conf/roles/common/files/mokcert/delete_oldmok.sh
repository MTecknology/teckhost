#!/bin/sh
##
# Dump currently enrolled keys and initial removal of unused keys.
##
. /usr/local/lib/shell

main() {
	parse_options "$@"
	safety_checks

	# Grab a lock
	lock acquire "$0" || die 'Another process seems to be running.'

	# Primary logic
	deletion_scheduled=1
	dump_mokcerts || die 'Failed to dump currently enrolled MOK certs'
	remove_old || log "$WARN" 'Error encountered removing old certs'

	# Primarily meant for -stateful:True
	if is_true "$deletion_scheduled"; then
		echo ""; echo "changed=yes comment='obsolete keys scheduled for deletion'"
	fi

	# Release the lock
	lock destroy "$0"
}

parse_options() {
	export OMOK_PATH="${OMOK_PATH:-/root/.mok/client.der}"
	export OMOK_DUMP="${OMOK_DUMP:-/root/.mok/dump}"
	export OMOK_SEARCH="${OMOK_SEARCH:-teckhost}"
	while getopts 'i:e:s:l:h' OPT; do
		case "$OPT" in
			i) OMOK_PATH="$OPTARG";;
			e) OMOK_DUMP="$OPTARG";;
			s) OMOK_SEARCH="$OPTARG";;
			l) export LOG_LEVEL="$OPTARG";;
			h) show_help; exit 1;;
			*) die "Unexpected argument provided: '$OPT'";;
		esac
	done
}


show_help() {
	t="$(printf '\t')"
	cat <<-EOF
		Dump currently enrolled keys and initial removal of unused keys.

		Usage: delete_oldmok [options]

		Options:
		  -i X${t}Path of imported certificate (default: /root/.mok/client.der)
		  -e X${t}Path to export enrolled certificates (default: /root/.mok/dump)
		  -s X${t}Search term used in binary search (default: teckhost)
		  -l X${t}Log level (default: 2 [warn])
		  -h${t}Print this help text and exit
		EOF
}


safety_checks() {
	[ -f "$OMOK_PATH" ] || die 'Client certificate import path not found.'
}


# Clean up export directory and dump currently enrolled certificates
dump_mokcerts() {
	[ -d "$OMOK_DUMP" ] || mkdir "$OMOK_DUMP"
	rm -f "$OMOK_DUMP"/*.der
	(cd "$OMOK_DUMP" && mokutil --export)
}


# Drop old/unused keys
remove_old() {
	_e=0
	for cert in "$OMOK_DUMP"/*.der; do
		if ! grep -qi "$OMOK_SEARCH" "$cert"; then
			log "$DEBUG" "Search term not found in $cert; skipping."
			continue
		elif cmp -s "$OMOK_PATH" "$cert"; then
			log "$DEBUG" "Enrollment expected for $cert; skipping."
			continue
		fi
		log "$INFO" "Requesting removal of $cert"
		(printf 'GR3en\nGR3en\n' | mokutil --delete "$cert") >/dev/null || _e=1
		mokutil --timeout 0
		deletion_scheduled=0
	done
	return $_e
}


# Kick off script execution
main "$@"
