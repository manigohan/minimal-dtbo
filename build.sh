#!/bin/sh
set -e

out="${PWD}/out"

if [ ! -e $out ]; then
  mkdir $out
else
  rm $out -rf
  mkdir $out
fi

for dev in *.dts; do
  device="${dev%.dts}"
  suffix="${device#*-}"

  cfg="dtboimg-$suffix.cfg"
  dts="${device}.dts"
  dtbo="${device}.dtbo"
  img="dtbo-$suffix.img"

  echo "[i] Building ${dtbo}"
  dtc -O dtb -o "${dtbo}" -b 0 -@ "${dts}"

  echo "[i] Creating $img"
  mkdtboimg cfg_create "${img}" "$cfg"
done

echo "[i] Done!"
mv *.dtbo *.img out/
ls out/
