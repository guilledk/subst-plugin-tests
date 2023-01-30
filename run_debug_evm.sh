docker run \
    -it --rm \
    --mount type=bind,source="$(pwd)",target=/root/target \
    guilledk/py-eosio:leap-subst \
    nodeos \
        --snapshot=snapshot-mainnet-20211026-blk-180635436.bin \
        --logconf=logging.json \
        --config=config.ini \
        --subst=2d6a868649e4eb5ba50441902df2b864aea4b126523a754206760c7cefa5907c:eosio.evm.debug.wasm
