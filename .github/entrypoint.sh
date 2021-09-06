#!/bin/sh -l

echo ""
echo "Installing dzil plugins"
echo ""

dzil authordeps --missing | cpanm

echo ""
echo "Installing distribution's prerequisites"
echo ""

dzil listdeps | cpanm

echo ""
echo "Executing dzil with the following arguments: "
echo "---------------------------------------------"
echo "$@"
echo "---------------------------------------------"
echo ""

$@

EXITCODE=$?

test $EXITCODE -eq 0 || echo "($EXITCODE) dzil failed, check logs";

exit $EXITCODE
