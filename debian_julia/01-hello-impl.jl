function do_hello()
    comm = MPI.COMM_WORLD
    println("\nHello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")
    MPI.Barrier(comm)
end
