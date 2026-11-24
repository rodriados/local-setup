# Personal workspace setup automation.
# @file Ansible lookup plugin for dotfiles.
# @author Rodrigo Siqueira <me@rodriados.com>
# @copyright 2026-present Rodrigo Siqueira
DOCUMENTATION = r"""
  name: dotfile
  author: Rodrigo Siqueira <me@rodriados.com>
  short_description: Search for dotfiles.
  description:
    - This lookup plugin searches for dotfiles in the user's home directory.
    - It can also handle local versions of dotfiles by appending a specified suffix.
  options:
    _terms:
      description: List of dotfile names to search for.
      required: True
      type: list
    must_exist:
      description: If True, only return files that exist.
      type: bool
      default: False
    avoid_local:
      description: If True, do not consider local versions of dotfiles.   
      type: bool
      default: False
    local_suffix:
      description: Suffix to append for local versions of dotfiles.
      type: str
      default: ".local"
    search_path:
      description: List of paths to search for dotfiles.
      type: list
      default: ["~"]
"""

import os
from itertools import chain

from ansible.errors import AnsibleError
from ansible.plugins.lookup import LookupBase

class LookupModule(LookupBase):
  """
  Lookup plugin for dotfiles.
  It searches for files in the user's home directory and returns their paths.
  It can also handle local versions of dotfiles by appending a specified suffix.
  """

  def run(self, terms, variables=None, **kwargs):
    """
    Searches for dotfiles in the specified search paths.
    :param terms: List of dotfile names to search for.
    :param variables: Optional variables for the lookup.
    :param kwargs: Additional keyword arguments:
      - must_exist: If True, only return files that exist.
      - avoid_local: If True, do not consider local versions of dotfiles.
      - local_suffix: Suffix to append for local versions of dotfiles.
      - search_path: List of paths to search for dotfiles.
    :return: List of found dotfile paths.
    """
    self.set_options(var_options = variables, direct = kwargs)

    self.must_exist = self.get_option('must_exist')
    self.avoid_local = self.get_option('avoid_local')
    self.local_suffix = self.get_option('local_suffix')
    self.search_path = map(os.path.expanduser, self.get_option('search_path'))
    return list(self._search_dotfile_in_path(self.search_path, terms))

  def _search_dotfile_in_path(self, pathlist, targetlist):
    """
    Searches for dotfiles in the given paths.
    :param pathlist: List of paths to search in.
    :param targetlist: List of dotfile names to search for.
    :return: Generator yielding found dotfile paths.
    """
    for path in pathlist:
      dotfiles   = [os.path.join(path, f) for f in targetlist]
      localfiles = [self._create_local_filename(f) for f in dotfiles]
      search_target_list = dotfiles if self.avoid_local else \
        chain.from_iterable(zip(localfiles, dotfiles))
      found = list(filter(os.path.exists, search_target_list))
      yield from (found if found or self.must_exist else dotfiles)

  def _create_local_filename(self, filename):
    """
    Creates a local version of the given filename by appending the local suffix.
    :param filename: The original filename.
    :return: The local version of the filename.
    """
    return f"{filename}{self.local_suffix}"
