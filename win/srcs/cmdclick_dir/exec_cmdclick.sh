#!/bin/bash

set -ue


LANG=C
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
readonly GREP_VCXSRV="vcxsrv"
readonly CMDCLICK_USE_SHELL='#!/bin/bash'

readonly ITEM_THREAD="ITEM_THREAD_CM2GUI"
readonly WINDOW_TITLE="Command Click"
readonly COMMAND_CLICK_EXTENSION='.sh'
readonly SOURCE_FILE_PATH="${0}"
readonly WIN_SOURCE_DIR_PATH="$(dirname $0)"
readonly WIN_LIB_DIR_PATH="${WIN_SOURCE_DIR_PATH}/lib"
readonly WIN_COMMON_LIB_DIR_PATH="${WIN_LIB_DIR_PATH}/common_lib"
readonly WIN_INPUT_GUI_LIB_DIR_PATH="${WIN_COMMON_LIB_DIR_PATH}/input_gui_lib"
readonly WIN_INIT_LIB_DIR_PATH="${WIN_COMMON_LIB_DIR_PATH}/init_lib"
cmdclick_win_srcs_path="$(dirname "${WIN_SOURCE_DIR_PATH}")"
cmdclick_win_dir_path="$(dirname "${cmdclick_win_srcs_path}")"
unset -v cmdclick_win_srcs_path
readonly SOURCE_DIR_PATH="$(dirname "${cmdclick_win_dir_path}")/linux/srcs/cmdclick_dir"
unset -v cmdclick_win_dir_path
readonly LIB_DIR_PATH="${SOURCE_DIR_PATH}/lib"
readonly COMMON_LIB_DIR_PATH="${LIB_DIR_PATH}/common_lib"
readonly INPUT_GUI_LIB_DIR_PATH="${COMMON_LIB_DIR_PATH}/input_gui_lib"
readonly INIT_LIB_DIR_PATH="${COMMON_LIB_DIR_PATH}/init_lib"
readonly EDIT_LIB_DIR_PATH="${LIB_DIR_PATH}/edit_lib"
readonly WINDOW_ICON_PATH="${SOURCE_DIR_PATH}/images/cmdclick_image.png"
readonly USER_HOME_DIR_PATH="/home/${USER}"
readonly CMDCLICK_ROOT_DIR_PATH="${USER_HOME_DIR_PATH}/cmdclick"
export CMDCLICK_CONF_DIR_PATH="${CMDCLICK_ROOT_DIR_PATH}/conf"
export CMDCLICK_APP_DIR_PATH="${CMDCLICK_CONF_DIR_PATH}/app"
readonly CMDCLICK_VALUE_SIGNAL_FILE_NAME="signal"
readonly CMDCLICK_VALUE_SIGNAL_FILE_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_VALUE_SIGNAL_FILE_NAME}"
readonly CMDCLICK_DEFAULT_INI_FILE_DIR_PATH="${CMDCLICK_ROOT_DIR_PATH}/default"
readonly CMDCLICK_DEFAULT_CD_FILE_NAME=$(echo ${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH} | sed 's/\//\_/g' | sed 's/^/cd\_/' | sed 's/$/'${COMMAND_CLICK_EXTENSION}'/' | sed 's/\_\_/\_/g')
readonly CMDCLICK_DEFAULT_CD_FILE_PATH="${CMDCLICK_APP_DIR_PATH}/${CMDCLICK_DEFAULT_CD_FILE_NAME}"
INI_FILE_DIR_PATH="${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH}"
readonly CMDCLICK_CONF_INC_CMD_NAME="cmdclidk_inc"
readonly CMDCLICK_CONF_INC_CMD_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_CONF_INC_CMD_NAME}"
readonly CMDCLICK_APP_LIST_NAME="cmdclidk_dir_list"
readonly CMDCLICK_APP_LIST_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_APP_LIST_NAME}"
readonly GREP_INC_NUM="INC_NUM"
readonly CMDCLICK_INI_SETTING_FILE_NAME="cmdclick_setting"
readonly CMDCLICK_INI_SETTING_FILE_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_INI_SETTING_FILE_NAME}"
readonly CMDCLICK_INI_PASTE_AFTER_ENTER="pasteAfterEnter"
readonly CMDCLICK_INI_PASTE_TARGET_TERMINAL_NAME="pasteTargetTerminalName"
readonly CMDCLICK_INI_OPEN_EDITOR_CMD="openEditorCmd"
readonly CMDCLICK_INI_CREATE_FILE_SHIBAN="shiban"
readonly CMDCLICK_INI_RUN_SHELL="runShell"
readonly PASTE_AFTER_ENTER_DEFAULT_VALUE="OFF"
readonly PASTE_TARGET_TERMINAL_DEFAULT_VALUE="WindowsTerminal"
readonly CMDCLICK_EDITOR_CMD_DEFAULT_VALUE="subl.exe"
readonly CMDCLICK_CREATE_FILE_SHIBAN_DEFAULT_VALUE="#!/bin/bash"
readonly CMDCLICK_RUN_SHELL_DEFAULT_VALUE="bash"
readonly CMDCLICK_SETTING_KEY_CON="${CMDCLICK_INI_PASTE_AFTER_ENTER}
${CMDCLICK_INI_PASTE_TARGET_TERMINAL_NAME}
${CMDCLICK_INI_OPEN_EDITOR_CMD}
${CMDCLICK_INI_CREATE_FILE_SHIBAN}
${CMDCLICK_INI_RUN_SHELL}"
readonly PASTE_AFTER_ENTER_DEFAULT_CB_VALUE="ON!OFF"
readonly CMDCLICK_DEFAULT_SETTING_CON="${CMDCLICK_INI_PASTE_AFTER_ENTER}=${PASTE_AFTER_ENTER_DEFAULT_VALUE}
${CMDCLICK_INI_PASTE_TARGET_TERMINAL_NAME}=${PASTE_TARGET_TERMINAL_DEFAULT_VALUE}
${CMDCLICK_INI_OPEN_EDITOR_CMD}=${CMDCLICK_EDITOR_CMD_DEFAULT_VALUE}
${CMDCLICK_INI_CREATE_FILE_SHIBAN}=${CMDCLICK_CREATE_FILE_SHIBAN_DEFAULT_VALUE}
${CMDCLICK_INI_RUN_SHELL}=${CMDCLICK_RUN_SHELL_DEFAULT_VALUE}"

SIGNAL_CODE=0
CHDIR_SIGNAL_CODE=0
#button code
readonly OK_CODE=0
readonly EXIT_CODE=1
readonly EDIT_CODE=2
readonly ADD_CODE=3
readonly DELETE_CODE=4
readonly DESCRIPTION_EDIT_CODE=5
readonly MOVE_CODE=6
readonly INSTALL_CODE=7
readonly INDEX_CODE=10
readonly CHECK_ERR_CODE=11
readonly SETTING_CODE=12
readonly CHDIR_CODE=20
readonly EDIT_FULL_CODE=22
readonly FORCE_EXIT_CODE=50
readonly EXIT_CODE_SOURCE=252
EXECUTE_COMMAND=""
CMD_CLICK_ADD_TITLE=""
INDEX_TITLE_TEXT_MESSAGE=""
readonly INDEX_SELECT_CMD_MESSAGE="please seclect command"
readonly INDEX_CD_DIR_CMD_MESSAGE="please seclect change dir command"
readonly ADD_COMMAND_MESSAGE="please type create command"
readonly ADD_CD_PATH_MESSAGE="please type after ${HOME} by ini_file dir path"
readonly SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME='CMD_VARIABLE_SECTION_START'
readonly INI_CMD_VARIABLE_SECTION_START_NAME="### ${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}"
readonly SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME='CMD_VARIABLE_SECTION_END'
readonly INI_CMD_VARIABLE_SECTION_END_NAME="### ${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}"
readonly INI_CMD_VARIABLE_SECTION_DEFAULT="${INI_CMD_VARIABLE_SECTION_START_NAME}
${INI_CMD_VARIABLE_SECTION_END_NAME}"
readonly CC_TERMINAL_NAME='CCerminal'
readonly SEARCH_INI_SETTING_SECTION_START_NAME='SETTING_SECTION_START'
readonly INI_SETTING_SECTION_START_NAME="### ${SEARCH_INI_SETTING_SECTION_START_NAME}"
readonly SEARCH_INI_SETTING_SECTION_END_NAME='SETTING_SECTION_END'
readonly INI_SETTING_SECTION_END_NAME="### ${SEARCH_INI_SETTING_SECTION_END_NAME}"
export SEARCH_INI_LABELING_SECTION_START_NAME='LABELING_SECTION_START'
readonly INI_LABELING_SECTION_START_NAME="### ${SEARCH_INI_LABELING_SECTION_START_NAME}"
export SEARCH_INI_LABELING_SECTION_END_NAME='LABELING_SECTION_END'
readonly INI_LABELING_SECTION_END_NAME="### ${SEARCH_INI_LABELING_SECTION_END_NAME}"
readonly INI_TERMINAL_ON='terminalDo'
readonly INI_OPEN_WHERE='openWhere'
readonly INI_TERMINAL_FOCUS='terminalFocus'
readonly INI_INPUT_EXECUTE='inputExecute'
readonly INI_IN_EXE_DFLT_VL='inputExecDfltVal'
readonly INI_BEFORE_COMMAND='beforeCommand'
readonly INI_AFTER_COMMAND='afterCommand'
readonly INI_CMD_FILE_NAME='shellFileName'
readonly INI_SETTING_KEY_LIST=("${INI_TERMINAL_ON}" "${INI_OPEN_WHERE}" "${INI_TERMINAL_FOCUS}" "${INI_INPUT_EXECUTE}" "${INI_IN_EXE_DFLT_VL}" "${INI_BEFORE_COMMAND}" "${INI_AFTER_COMMAND}" "${INI_CMD_FILE_NAME}")
readonly SEARCH_INI_CMD_SECTION_START_NAME="### Please write bellow with shell script"
export CH_DIR_PATH='CH_DIR_PATH'

readonly INI_TERMINAL_ON_DEFAULT_GAIN="ON"
readonly INI_OPEN_WHERE_DEFAULT_GAIN="CW"
readonly INI_TERMINAL_FOCUS_DEFAULT_GAIN="OFF"
readonly INI_INPUT_EXECUTE_DEFAULT_GAIN="N"
readonly INI_IN_EXE_DFLT_VL_DEFAULT_GAIN=""
readonly INI_BEFORE_COMMAND_DEFAULT_GAIN=""
readonly INI_AFTER_COMMAND_DEFAULT_GAIN=""
readonly INI_INI_CMD_FILE_NAME_DEFAULT_GAIN=""

readonly INI_SETTING_DEFAULT_GAIN_LIST=("${INI_TERMINAL_ON_DEFAULT_GAIN}" "${INI_OPEN_WHERE_DEFAULT_GAIN}" "${INI_TERMINAL_FOCUS_DEFAULT_GAIN}" "${INI_BEFORE_COMMAND_DEFAULT_GAIN}" "${INI_AFTER_COMMAND_DEFAULT_GAIN}" "${INI_INI_CMD_FILE_NAME_DEFAULT_GAIN}")
readonly INI_SETTING_DEFAULT_GAIN_CON="${INI_TERMINAL_ON}=${INI_TERMINAL_ON_DEFAULT_GAIN}
${INI_OPEN_WHERE}=${INI_OPEN_WHERE_DEFAULT_GAIN}
${INI_TERMINAL_FOCUS}=${INI_TERMINAL_FOCUS_DEFAULT_GAIN}
${INI_INPUT_EXECUTE}=${INI_INPUT_EXECUTE_DEFAULT_GAIN}
${INI_IN_EXE_DFLT_VL}=
${INI_BEFORE_COMMAND}=
${INI_AFTER_COMMAND}=
${INI_CMD_FILE_NAME}="

readonly INI_TERMINAL_ON_DEFAULT_VALUE="ON!OFF"
readonly INI_OPEN_WHERE_DEFAULT_VALUE="CW!NT"
readonly INI_TERMINAL_FOCUS_DEFAULF_VALUE="OFF!ON"
readonly INI_INPUT_EXECUTE_DEFAULF_VALUE="N!C!E"
readonly INI_IN_EXE_DFLT_VL_DEFAULT_VALUE=""
readonly INI_BEFORE_COMMAND_DEFAULT_VALUE=""
readonly INI_AFTER_COMMAND_DEFAULT_VALUE=""
readonly INI_INI_CMD_FILE_NAME_DEFAULT_VALUE=""
readonly INI_SETTING_DEFAULT_VALUE_CONS="${INI_TERMINAL_ON}=${INI_TERMINAL_ON_DEFAULT_VALUE}
${INI_OPEN_WHERE}=${INI_OPEN_WHERE_DEFAULT_VALUE}
${INI_TERMINAL_FOCUS}=${INI_TERMINAL_FOCUS_DEFAULF_VALUE}
${INI_INPUT_EXECUTE}=${INI_INPUT_EXECUTE_DEFAULF_VALUE}
${INI_IN_EXE_DFLT_VL}=${INI_IN_EXE_DFLT_VL_DEFAULT_VALUE}
${INI_BEFORE_COMMAND}=${INI_BEFORE_COMMAND_DEFAULT_VALUE}
${INI_AFTER_COMMAND}=${INI_AFTER_COMMAND_DEFAULT_VALUE}
${INI_CMD_FILE_NAME}=${INI_INI_CMD_FILE_NAME_DEFAULT_VALUE}"

readonly INI_TERMINAL_ON_VALUE_CATEGORY=":CB"
readonly INI_OPEN_WHERE_VALUE_CATEGORY=":CB"
readonly INI_TERMINAL_FOCUS_VALUE_CATEGORY=":CB"
readonly INI_INPUT_EXECUTE_VALUE_CATEGORY=":CB"
readonly INI_BEFORE_COMMAND_VALUE_CATEGORY=""
readonly INI_AFTER_COMMAND_VALUE_CATEGORY=""
readonly INI_CMD_FILE_NAME_VALUE_CATEGORY=""

readonly INI_SETTING_VALUE_CATEGORY_CONS="${INI_TERMINAL_ON_VALUE_CATEGORY}
${INI_OPEN_WHERE_VALUE_CATEGORY}
${INI_TERMINAL_FOCUS_VALUE_CATEGORY}
${INI_INPUT_EXECUTE_VALUE_CATEGORY}
${INI_BEFORE_COMMAND_VALUE_CATEGORY}
${INI_AFTER_COMMAND_VALUE_CATEGORY}
${INI_CMD_FILE_NAME_VALUE_CATEGORY}"

EXEC_TERMINAL_ON=""
EXEC_OPEN_WHERE="" 
EXEC_WORKING_DIRECTORY="" 
EXEC_TERMINAL_FOCUS=""
EXEC_INPUT_EXECUTE=""
EXEC_BEFORE_COMMAND="" 
EXEC_AFTER_COMMAND="" 
EXEC_EXEC_WAKE=""

EDIT_EDITOR_ON=""
case  "${IMPORT_CMDCLICK_VAL:-}" in 
	"");; *) return;; esac
. "${LIB_DIR_PATH}/check_ini_file.sh"
. "${LIB_DIR_PATH}/check_ini_std_out.sh"
. "${EDIT_LIB_DIR_PATH}/edit_ini_file.sh"
. "${INPUT_GUI_LIB_DIR_PATH}/judge_signal_code.sh"
. "${INPUT_GUI_LIB_DIR_PATH}/upgrade_app_dir_list_order.sh"
. "${INPUT_GUI_LIB_DIR_PATH}/echo_display_ini_file_dir_path.sh"
. "${INIT_LIB_DIR_PATH}/set_default_setting_value.sh"
. "${INIT_LIB_DIR_PATH}/make_requrement_dir.sh"
. "${COMMON_LIB_DIR_PATH}/echo_by_convert_xml_escape_sequence.sh"
. "${COMMON_LIB_DIR_PATH}/echo_removed_double_quote_both_ends.sh"
. "${COMMON_LIB_DIR_PATH}/fetch_parameter_from_pip.sh"
. "${COMMON_LIB_DIR_PATH}/mv_ini_file_when_rename.sh"
. "${COMMON_LIB_DIR_PATH}/echo_by_remove_pre_or_suffix_single_quote.sh"
. "${COMMON_LIB_DIR_PATH}/echo_labeling_section_bitween_start_and_end.sh"
. "${COMMON_LIB_DIR_PATH}/echo_only_parameter_value.sh"
. "${COMMON_LIB_DIR_PATH}/replace_home_dir_path_by_tilde.sh"
. "${COMMON_LIB_DIR_PATH}/confirm_edit_contensts.sh"
. "${COMMON_LIB_DIR_PATH}/choose_app_dir_list_for_move.sh"
. "${WIN_COMMON_LIB_DIR_PATH}/input_gui.sh"
. "${WIN_COMMON_LIB_DIR_PATH}/reactive_when_aleady_exist_cmdclick.sh"
. "${WIN_INIT_LIB_DIR_PATH}/read_resolution_from_system.sh"
export -f fetch_parameter
export -f fetch_parameter_from_pip
export -f echo_labeling_section_bitween_start_and_end
export -f echo_labeling_section_bitween_start_and_end_from_pip
export -f replace_home_dir_path_by_tilde
LOOP=0
SIGNAL_CODE=${INDEX_CODE}
NORMAL_SIGNAL_CODE=${INDEX_CODE}
ACTIVE_CHECK_VARIABLE=0

execute_cmd_by_xdotool(){
	local exec_cmd="${1}"
	local ccerminal_acctive_window_name="${2}"
	case "${ccerminal_acctive_state}" in 
		"");;
		*) 
			local clip_con=$(xclip -selection c -o)
			echo "${exec_cmd}" | xclip -selection c
			sleep 0.01
			cmd.exe /c start wmctrl.exe -a "${ccerminal_acctive_window_name}"
			sleep 0.2
			nircmd.exe sendkeypress ctrl+shift+v
			nircmd.exe sendkeypress enter
			test "${PASTE_AFTER_ENTER_BOOL}" == "ON" \
				&& nircmd.exe sendkeypress enter
    		echo -n "${clip_con}" | xclip -selection c &
    		;;
    esac
}


open_editor(){
	cd "$(dirname "${1}")"
    ${CMDCLICK_EDITOR_CMD_STR} "$(basename "${1}")"
    cmd.exe /c start ${CMDCLICK_EDITOR_CMD_STR}
}
export -f open_editor


init(){
	make_requrement_dir
	set_default_setting_value
	# change default dir file make 
	if [ ! -e ${CMDCLICK_DEFAULT_CD_FILE_PATH} ];then 
		add_chdir_cmd_ini_file \
			"${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH}"
	fi
	read_resolution_from_system
	# for win11
	nircmd.exe win hide process wsl.exe &
	# for win10
	nircmd.exe win hide title "管理者: C:\Windows\System32\bash.exe" &
}


init


while true :
do
	case "${NORMAL_SIGNAL_CODE}" in
		"${INDEX_CODE}")
			. "${LIB_DIR_PATH}/index.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE}
			;;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${OK_CODE}")
			. "${WIN_LIB_DIR_PATH}/execute.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${ADD_CODE}")
			. "${LIB_DIR_PATH}/add_cmd.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${EDIT_CODE}")
			. "${LIB_DIR_PATH}/edit.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${DESCRIPTION_EDIT_CODE}")
			. "${LIB_DIR_PATH}/description_edit.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${MOVE_CODE}")
			. "${LIB_DIR_PATH}/move.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${INSTALL_CODE}")
			. "${LIB_DIR_PATH}/install.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${DELETE_CODE}")
			. "${LIB_DIR_PATH}/delete.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${CHDIR_CODE}")
			. "${LIB_DIR_PATH}/add_chdir.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${SETTING_CODE}")
			. "${LIB_DIR_PATH}/setting.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE} ;;
	esac

	case "${NORMAL_SIGNAL_CODE}" in 
		"${FORCE_EXIT_CODE}")
			LOOP=0
			exit 0 ;;
	esac

	case "${LOOP}" in 
		"5")
			exit 0 ;;
	esac
	LOOP=$(expr ${LOOP} + 1)
done
