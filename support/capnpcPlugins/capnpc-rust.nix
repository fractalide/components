{ buffet }:

buffet.support.rs.executable {
  name = "capnpc-rust";
  mods = with buffet.mods.rs; [ capnp capnpc ];
  src = buffet.pkgs.fetchFromGitHub {
    owner = "dwrensha";
    repo = "capnpc-rust";
    rev = "53e7c94882ec77bac7df70e0922989183caca8f7";
    sha256 = "131n5l3lk88fvs1fm763a3ix5in2642xhdrk47x3y3d07cp34wwp";
  };
}
