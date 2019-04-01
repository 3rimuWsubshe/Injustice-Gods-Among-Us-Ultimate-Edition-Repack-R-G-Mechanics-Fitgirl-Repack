local pldir = require 'pl.dir'
local plfile = require 'pl.file'
local plpath = require 'pl.path'
local except = require 'euluna.utils.except'

local fs = {}

fs.join = plpath.join
fs.tryreadfile = plfile.read
fs.abspath = plpath.abspath
fs.getbasename = plpath.basename
fs.getpathdir = plpath.dirname
fs.getfiletime = plfile.modified_time

function fs.ensurefilepath(file)
  local outdir = plpath.dirname(file)
  local ok, err = pldir.makepath(outdir)
  except.assertraisef(ok, 'failed to create path for file "%s": %s', err)
end

function fs.writefile(file, content)
  local ok, err = plfile.write(file, content)
  except.assertraisef(ok, 'failed to create file "%s": %s', file, err)
end

function fs.readfile(file)
  local content, err = plfile.read(file)
  return except.assertraisef(content, 'failed to read file "%s": %s', file, err)
end

function fs.getcachepath(infile, cachedir)
  local path = infile:gsub('%.[^.]+$','')
  path = plpath.relpath(path)
  path = path:gsub('%.%.[/\\]+', '')
  path = plpath.join(cachedir, path)
  path = plpath.normpath(path)
  return path
end

return fs