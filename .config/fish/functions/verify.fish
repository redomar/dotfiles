#
# Verifies crc32 of a given file to file name hash
# ONLY FOR VALIDATING DOWNLOAD FILE NOT CORRUPTED/INCOMPLETE
#
# Expected:   return Passed if crc32 equals filename checksum value
# Unexpected: return Failed if crc32 does not equal to filename checksum
#
# Mohamed Omar 24 Jan 2020
# GitHub: redomar

function verify --description 'Compare CRC with Filename CRC' -a all
  argparse 'a/all' -- $argv
  if set -q _flag_all
    for i in (/bin/ls $PWD)
      if test -f $i
        verify $i
      end
    end
    return 0
  end
  if test -z $argv
    echo -e '\n usage: verify FILENAME\n'
    return 2
  else if test -d $argv
    echo -e "Ignoring directory \e[94;4m$argv/\e[0m"
    return 1
  end

  set -lx fileHash (/bin/ls $argv | grep -Ee '[0-9A-F]{8}' -o)

  if test -z "$fileHash"
    echo 'No Checksum value in file name:' $argv
    return 1
  end

  set -lx hash (crc32 $argv 2>/dev/null | tr a-z A-Z | cut -c 1-8 | grep -Ee '[0-9A-F]{8}' -o)
  set -l filename (basename $argv)

  if test "$hash" = "$fileHash"
    echo -e "Checksum Passed \e[30;42m $hash = $fileHash \e[0m"
  else
    echo -e "\e[30;41mChecksum Failed $hash != $fileHash \e[5;31;40m UNSAFE -> \e[0;4;93m$filename\e[0m"
    return 2
  end
end

