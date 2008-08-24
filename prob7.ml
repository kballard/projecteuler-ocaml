(*
  By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

  What is the 10001st prime number?
*)

#load "sieve.cmo"

let sieve = Sieve.make 200000

let _ =
  print_int (Sieve.find_prime 10001 sieve); print_newline ()
