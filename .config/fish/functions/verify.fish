#
# Verifies crc32 of a given file to file name hash
# ONLY FOR VALIDATING DOWNLOAD FILE NOT CORRUPTED/INCOMPLETE
#
# Expected:   return Passed if crc32 equals filename checksum value
# Unexpected: return Failed if crc32 does not equal to filename checksum
#
# Mohamed Omar 24 Jan 2020
# GitHub: redomar

function verify -d "Compare CRC with Filename CRC"
    if test -z $argv
	echo -e '\n usage: verify FILENAME\n'
	return 2
    end

    set -lx hash (crc32 $argv | tr a-z A-Z | grep -Ee '[0-9A-F]{8}' -o)
    set -lx fileHash (ls $argv | grep -Ee '[0-9A-F]{8}' -o)

    if test -z "$fileHash"
	echo 'No Checksum value in file name:' $argv
	return 1
    else if test $hash = $fileHash
	echo 'Checksum Passed:' $hash '=' $fileHash
    else
	echo 'Checksum Failed:' $hash '!=' $fileHash
	echo -e '\e[0;31;5m UNSAFE'
        return 2
    end
end
