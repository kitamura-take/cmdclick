#!/bin/bash


set -eu
readonly EDIT_FILE_PATH="${1}"
readonly EDIT_WINDOW_LOCATION="${2}"
readonly exec_path_in_make_ini_contents_lib="$(dirname "${0}")"
readonly make_ini_contents_lib_path=$(dirname "${exec_path_in_make_ini_contents_lib}")
readonly edit_ini_file_lib=$(dirname "${make_ini_contents_lib_path}")
readonly edit_lib=$(dirname "${edit_ini_file_lib}")
readonly cmdclick_lib=$(dirname "${edit_lib}")
readonly common_lib="${cmdclick_lib}/common_lib"
readonly CMDCLICK_DIR=$(dirname "${cmdclick_lib}")
readonly exec_cmdclick_path="${CMDCLICK_DIR}/exec_cmdclick.sh"
readonly IMPORT_CMDCLICK_VAL=1


display_discription(){
	local edit_file_path="${1}"
	local edit_window_location="${2}"
	local LANG="ja_JP.UTF-8"
	. "${exec_cmdclick_path}"
	. "${common_lib}/echo_by_convert_xml_escape_sequence.sh"
	local EDIT_DESCRIPTION=$(\
		echo_labeling_section_bitween_start_and_end \
			"$(cat "${edit_file_path}")" \
			"print" \
	)
	case "${EDIT_DESCRIPTION}" in
		"") return 
		;;
	esac
	EDIT_DESCRIPTION="$(\
		echo_by_convert_xml_escape_sequence_new_line \
			"${EDIT_DESCRIPTION}"\
	)"
	local LANG="ja_JP.UTF-8"
	echo "${CMDCLICK_WINDOW_ICON_PATH}"
    yad \
    --form \
    --title="${CMDCLICK_WINDOW_TITLE}" \
    --window-icon="${CMDCLICK_DIR}/images/cmdclick_image.png" \
    --text="\n${EDIT_DESCRIPTION} \n" \
    --borders=${CMDCLICK_BORDER_NUM} \
    ${edit_window_location} \
    --scroll 
}

display_discription \
	"${EDIT_FILE_PATH}" \
	"${EDIT_WINDOW_LOCATION}"