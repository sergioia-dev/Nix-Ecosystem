{
  pkgs ? import <nixpkgs> {},
  lib,
  ...
}: let
  buildShellExtension = pkgs.callPackage ./buildGnomeExtension.nix {};
in
  buildShellExtension {
    pname = "dynamic-music-pill";
    name = "Dynamic Music Pill";
    description = "An elegant, pill-shaped music player for your desktop. Features a smooth audio visualizer, scrolling text, and seamless integration with Dash-to-Dock and the Top Panel.";
    uuid = "dynamic-music-pill@andbal";
    version = 29;
    link = "https://github.com/Andbal23/dynamic-music-pill";
    sha256 = "sha256-h3gjaCaJVySnrNWddLIwFCPbBhj0UiAhWQNokHAIG0E=";
    metadata = "ewogICJuYW1lIjogIkR5bmFtaWMgTXVzaWMgQmlsbCIsCiAgImdldHRleHQtZG9tYWluIjogImR5bmFtaWMtbXVzaWMtcGlsbCIsCiAgImRlc2NyaXB0aW9uIjogIkFuIGVsZWdhbnQgcGlsbC1zaGFwZWQgbXVzaWMgcGxheWVyIGZvciB5b3VyIGRlc2t0b3AuIEZlYXR1cmVzIGEgc21vb3RoIGF1ZGlvIHZpc3VhbGl6ZXIsIHNjcm9sbGluZyB0ZXh0LCBhbmQgc2VhbWxlc3MgaW50ZWdyYXRpb24gd2l0aCBEYXNoLXRvLURvY2sgYW5kIHRoZSBUb3AgUGFuZWwuIENvbWVzIHdpdGggYSBQb3VwLU1lbnUuIiwKICAidXVpZCI6ICJkeW5hbWljLW11c2ljLXBpbGxAYW5kYmFsIiwKICAic2hlbGwtdmVyc2lvbiI6IFsiNDUiLCAiNDYiLCAiNDciLCAiNDgiLCAiNDkiXSwKICAidXJsIjogImh0dHBzOi8vZ2l0aHViLmNvbS9BbmRiYWwyMy9keW5hbWljLW11c2ljLXBpbGwiLAogICJzZXR0aW5ncy1zY2hlbWEiOiAib3JnLmdub21lLnNoZWxsLmV4dGVuc2lvbnMuZHluYW1pYy1tdXNpYy1waWxsIiwKICAidmVyc2lvbiI6IDI5LAogICJ2ZXJzaW9uLW5hbWUiOiAiMS4wLjAiCn0=";
  }

