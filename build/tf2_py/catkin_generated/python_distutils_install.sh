#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/trang/catkin_ws6/src/geometry2-noetic-devel/tf2_py"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/trang/catkin_ws6/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/trang/catkin_ws6/install/lib/python3/dist-packages:/home/trang/catkin_ws6/build/tf2_py/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/trang/catkin_ws6/build/tf2_py" \
    "/usr/bin/python3" \
    "/home/trang/catkin_ws6/src/geometry2-noetic-devel/tf2_py/setup.py" \
    egg_info --egg-base /home/trang/catkin_ws6/build/tf2_py \
    build --build-base "/home/trang/catkin_ws6/build/tf2_py" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/trang/catkin_ws6/install" --install-scripts="/home/trang/catkin_ws6/install/bin"
