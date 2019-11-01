#!/bin/bash

PROJECT_ROOT=$(realpath $(dirname $0))
DEPENDENCIES_DIR="$PROJECT_ROOT/external_dependencies"
DEPENDENCIES_LIB_DIR="$DEPENDENCIES_DIR/lib"
DEPENDENCIES_INCLUDE_DIR="$DEPENDENCIES_DIR/include"
DEPENDENCIES_OBJS_DIR="$DEPENDENCIES_DIR/objs"
DEPENDENCY_MANAGER_DIR="$PROJECT_ROOT/.assertions/dependency_manager"

mkdir -p "$DEPENDENCIES_LIB_DIR"
mkdir -p "$DEPENDENCIES_INCLUDE_DIR"
mkdir -p "$DEPENDENCIES_OBJS_DIR"

############### Command Line Interface ##################
print_help () {
	echo "Help:"
	echo "Manage dependencies for the project"
	echo
	echo "Usage: ./dependencies.sh ACTION"
	echo
	echo "ACTION:"
	echo "	add: add new dependency to the project. Use './dependencies.sh add --help' for more information"
	echo "	remove: remove dependency from the project. Use './dependencies.sh remove --help' for more information"
	echo "	clean: delete all downloaded dependencies (everything inside ./external_dependencies)"
	echo "	install: download and configure all dependencies"
	echo "	list: list all project's dependencies"
}

determine_dependency_list_is_empty() {
	DEPENDENCY_LIST=$(awk FNR!=1 "$DEPENDENCY_MANAGER_DIR/install.sh")
	if [ "$DEPENDENCY_LIST" == "" ]; then
		DEPENDENCY_LIST_IS_EMPTY=true
	else
		DEPENDENCY_LIST_IS_EMPTY=""
	fi
}

if [ "$1" == "--help" ]; then
	print_help
	exit 0
elif [ "$1" == "add" ]; then
	shift
	source "$PROJECT_ROOT/.assertions/dependency_manager/add.sh"
elif [ "$1" == "remove" ]; then
	shift
	source "$PROJECT_ROOT/.assertions/dependency_manager/remove.sh"
elif [ "$1" == "clean" ]; then
	echo "Are you sure you want to delete all downloaded dependencies? (y/n)"
	read CONFIRMATION
	if [ "${CONFIRMATION[0]}" == "y" ] || [ "${CONFIRMATION[1]}" == "Y" ]; then
		rm -rf "$PROJECT_ROOT/external_dependencies"
		echo "Info: Downloaded dependencies deleted"
	else
		echo "Info: Operation cancelled"
	fi
elif [ "$1" == "list" ]; then
	determine_dependency_list_is_empty
	if [ $DEPENDENCY_LIST_IS_EMPTY ]; then
		echo "Info: project has no external dependencies"
	else
		echo "$DEPENDENCY_LIST" | sed "s/\/install\.sh//g"
	fi
elif [ "$1" == "install" ]; then
	determine_dependency_list_is_empty
	if [ $DEPENDENCY_LIST_IS_EMPTY ]; then
		echo "Info: project has no external dependencies"
	else
		cd "$DEPENDENCY_MANAGER_DIR/modules"
		source "$DEPENDENCY_MANAGER_DIR/install.sh"
	fi
else
	echo "Error: unknown action '$1'"
	echo
	print_help
	exit 1
fi
############### Command Line Interface ##################

