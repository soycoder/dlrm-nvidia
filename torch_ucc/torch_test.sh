/opt/ucx/bin/ucx_info -e -u t
export UCX_LOG_LEVEL=info
echo "UCC barrier"
/bin/bash /torch_ucc/test/start_test.sh /torch_ucc/test/torch_barrier_test.py --backend=gloo
echo "UCC alltoall"
/bin/bash /torch_ucc/test/start_test.sh /torch_ucc/test/torch_alltoall_test.py --backend=gloo
echo "UCC alltoallv"
/bin/bash /torch_ucc/test/start_test.sh /torch_ucc/test/torch_alltoallv_test.py --backend=gloo
echo "UCC allgather"
/bin/bash /torch_ucc/test/start_test.sh /torch_ucc/test/torch_allgather_test.py --backend=gloo
echo "UCC allreduce"
/bin/bash /torch_ucc/test/start_test.sh /torch_ucc/test/torch_allreduce_test.py --backend=gloo
echo "UCC broadcast"
/bin/bash /torch_ucc/test/start_test.sh /torch_ucc/test/torch_bcast_test.py --backend=gloo