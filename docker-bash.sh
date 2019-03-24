#! /bin/bash

# for debugging with gdb
config=" --cap-add=SYS_PTRACE --security-opt seccomp=unconfined "

unameOut="$(uname -s)"
case "$unameOut" in
	Linux*)
		x11=" -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:$HOME/.Xauthority --net=host "
		config="$config $x11 "
	;;

	Darwin*)
		# allow access from localhost
		xhost + 127.0.0.1

		x11="-e DISPLAY=docker.for.mac.localhost:0"
		config="$config $x11"
	;;

	*)
		echo "Not supported OS!"
		exit 1
	;;
esac

docker run -it --rm=true \
		-e USER=$USER -e USERID=$UID \
		-v $HOME:/home/qt \
		$config \
		--entrypoint /bin/bash \
		--name ubuntu-qt-5.4-bash pddthinh/ubuntu-qt-5.4
