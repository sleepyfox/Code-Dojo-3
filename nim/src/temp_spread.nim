# Module temp_spread
import strutils

type
  Temp* = object
    year*: int
    month*: int
    max_temp*: float
    min_temp*: float

type
  TempSpread* = object
    year*: int
    month*: int
    temp_spread*: float

proc `<`*(a, b: TempSpread): bool =
  a.temp_spread < b.temp_spread

proc spread*(t: Temp): TempSpread =
  TempSpread(year: t.year,
             month: t.month,
             temp_spread: t.max_temp - t.min_temp)


proc strings_to_temp*(ts: seq[string]): Temp =
  Temp(year: ts[0].parseInt(),
       month: ts[1].parseInt(),
       max_temp: ts[2].parseFloat(),
       min_temp: ts[3].parseFloat())

proc temp_reader*(line: string): seq[string] =
  splitWhitespace(line)

proc process_file*(path: string): seq[string] =
  splitLines(readFile(path))[7..^2] # remove header
