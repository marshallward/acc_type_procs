Procedure pointers and type-bound procedures on the GPU
=======================================================

Lessons so far:

* Procedure pointers can point to procedures containing GPU code ("acc kernel
  regions").  There does not seem to be any restriction here with respect to
  polymorphism, since it's all happening on the CPU side.

* Procedure pointers *cannot* appear inside kernel regions.  GPU has no idea
  what they are and claims that the "data" is not present on the GPU.

  Adding !$acc region to the target procedure (or even the interface) does not
  seem to help.

* TODO: elementals...
