#!bin/bash


CHDIR_LIB_DIR_PATH="${LIB_DIR_PATH}/add_chdir_lib"
CHDIR_SIGNAL_CODE=${INDEX_CODE}


while true :
do 
	if [ ${CHDIR_SIGNAL_CODE} -eq ${INDEX_CODE} ];then
		CHDIR_LOOP=0
		#index立ち上げ
		INDEX_TITLE_TEXT_MESSAGE=${INDEX_CD_DIR_CMD_MESSAGE}
		input_cmd_index
		CHDIR_SIGNAL_CODE=${SIGNAL_CODE}
	fi

	if [ ${CHDIR_SIGNAL_CODE} -eq ${ADD_CODE} ]; then
		CHDIR_LOOP=0
		. "${CHDIR_LIB_DIR_PATH}/chdir_roop.sh"
		CHDIR_SIGNAL_CODE=${SIGNAL_CODE}
	fi

	if [ ${CHDIR_SIGNAL_CODE} -eq ${OK_CODE} ]; then
		CHDIR_LOOP=0
		INI_FILE_DIR_PATH=${CMDCLICK_APP_DIR_PATH}
		. "${LIB_DIR_PATH}/execute.sh"
		echo "${GREP_INC_NUM}=1" > "${CMDCLICK_CONF_INC_CMD_PATH}"
		CHDIR_SIGNAL_CODE=${FORCE_EXIT_CODE}
	fi

	if [ ${CHDIR_SIGNAL_CODE} -eq ${EDIT_CODE} ]; then
		CHDIR_LOOP=0
		INI_FILE_DIR_PATH=${CMDCLICK_APP_DIR_PATH}
		. "${LIB_DIR_PATH}/edit.sh"
		CHDIR_SIGNAL_CODE=${SIGNAL_CODE}
	fi

	if [ ${CHDIR_SIGNAL_CODE} -eq ${DESCRIPTION_EDIT_CODE} ]; then
		CHDIR_LOOP=0
		INI_FILE_DIR_PATH=${CMDCLICK_APP_DIR_PATH}
		. "${LIB_DIR_PATH}/description_edit.sh"
		CHDIR_SIGNAL_CODE=${SIGNAL_CODE}
	fi

	if [ ${CHDIR_SIGNAL_CODE} -eq ${DELETE_CODE} ]; then
		CHDIR_LOOP=0
		INI_FILE_DIR_PATH=${CMDCLICK_APP_DIR_PATH}
		. "${LIB_DIR_PATH}/delete.sh"
		CHDIR_SIGNAL_CODE=${SIGNAL_CODE}
	fi


	if [ ${CHDIR_SIGNAL_CODE} -ge ${FORCE_EXIT_CODE} ] || [ ${CHDIR_SIGNAL_CODE} -eq ${EXIT_CODE} ]; then
		CHDIR_LOOP=0
		SIGNAL_CODE=${INDEX_CODE}
		unset -v CHDIR_LIB_DIR_PATH
		break
	fi

	if [ ${CHDIR_LOOP} -eq 5 ]; then
		unset -v CHDIR_LIB_DIR_PATH
		break
	fi
	CHDIR_LOOP=$(expr ${CHDIR_LOOP} + 1)
done