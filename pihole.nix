{ config, pkgs, buildImage, ... }:
{
  buildImage {
    imageName = "pihole/pihole";
    finalImageTag = "4.1";
    imageDigest = "sha256:3c165a8656d22b75ad237d86ba3bdf0d121088c144c0b2d34a0775a9db2048d7";
    sha256 = "132n8dz1k4k759fm5dzfb74218rv84wzn24kjwfl8fwmc6h28fsf";
  };
}
