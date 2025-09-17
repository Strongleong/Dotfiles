#!/bin/sh

progname=$(basename $0)
percent=$1
ms=$2
backend=brightnessctl
brightness_max=0
brightness_cur=0

usage()
{
  echo "Usage: $progname <brighess (in percentage)> <duraction (in ms)>"
  echo "  Exampe: $progname 30 200"
}

lerp()
{
  factor=$1
  a=$2
  b=$3

  echo $(perl -e "print $factor * $a + (1.0 - $factor) * $b")
}

handle_args()
{
  if ! [[ "$percent" =~ ^[0-9]+$ ]]; then
    usage; exit 1
  fi

  if ! [[ "$ms" =~ ^[0-9]+$ ]]; then
    usage; exit 1
  fi

  if (( $percent > 100)); then
    percent=100
  fi

  if (( $percent < 10)); then
    percent=10
  fi
}

backend_check()
{
  which $backend &> /dev/null
  if [ $? -ne 0 ]; then
    echo "Error: no $backend found"; exit 1
  fi
}

backend_get_max()
{
  brightness_max=$($backend max)
}

backend_get_cur()
{
  brightness_cur=$($backend get)
}

backend_set()
{
  value=$1
  $backend set $value
}

main()
{
  handle_args

  backend_check
  backend_get_max
  backend_get_cur

  target_value=$(($brightness_max / 100 * $percent))

  for ((i = 0; i < $ms; i++)); do
    factor=$(perl -e "print $i / $ms")
    value=$(lerp $factor $target_value $brightness_cur)
    backend_set $value
    sleep 0.0001
  done

  # echo $percent
}

main $@
