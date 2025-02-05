xquery version "3.1";
module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace ik-fn = "http://www.ilmarikoria.xyz" at "lib-publish.xqm";

declare %unit:test function test:assert-equals-hello-world() {
  unit:assert-equals(
    ik-fn:hello-world(),
    "Hello, World"
    )
};
