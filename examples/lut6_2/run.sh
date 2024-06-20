#!/bin/bash
source ../../common/env.sh

# echo $DBROOT

export PART=xc7a35tfgg484-2
export PART_FILE=$DBROOT/$PART/part.yaml

mkdir build
cd build

$YOSYS -p "synth_xilinx -flatten -nowidelut -abc9 -arch xc7 -top top; write_json synth.json; show -format dot -prefix synth1" ../top.v

# pack
$NEXTPNR --chipdb $ARCH_BIN --xdc ../$PART.xdc --json synth.json -l log_pack.log --debug --pack-only --write pack.json
# place
$NEXTPNR --chipdb $ARCH_BIN --xdc ../$PART.xdc --json pack.json -l log_place.log --debug --no-pack --no-route --write place.json
# route
$NEXTPNR --chipdb $ARCH_BIN --xdc ../$PART.xdc --json place.json -l log_route.log --debug --no-pack --no-place --write route.json --fasm top.fasm

$XCFASM        \
    --db-root $DBROOT \
    --part $PART \
    --part_file $PART_FILE \
    --sparse \
    --frm2bit $XC7FRAMES2BIT \
    --emit_pudc_b_pullup \
    --fn_in top.fasm \
    --bit_out top.bit

cd ..