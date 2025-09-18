#
# Verifies crc32 of a given file to file name hash
# ONLY FOR VALIDATING DOWNLOAD FILE NOT CORRUPTED/INCOMPLETE
#
# Expected:   return Passed if crc32 equals filename checksum value
# Unexpected: return Failed if crc32 does not equal to filename checksum
#
# Mohamed Omar 24 Jan 2020
# GitHub: redomar


function verify2 --description 'Compare CRC with Filename CRC'
  set -l file $argv[1]

  if test -z "$file"
    echo -e '\n usage: verify FILENAME\n'
    return 2
  else if test -d "$file"
    echo -e "Ignoring directory \e[94;4m$file/\e[0m"
    return 1
  end

  set -lx fileHash (string match -r '[0-9A-F]{8}' -- $file)

  if test -z "$fileHash"
    echo "No Checksum value in file name: $file"
    return 1
  end

  set -lx hash (crc32 $file 2>/dev/null | tr a-z A-Z | cut -c 1-8)

  if test "$hash" = "$fileHash"
    echo -e "Checksum Passed \e[30;42m $hash = $fileHash \e[0m"
  else
    echo -e "\e[30;41mChecksum Failed $hash != $fileHash \e[5;31;40m UNSAFE -> \e[0;4;93m$file\e[0m"
    return 2
  end
end

