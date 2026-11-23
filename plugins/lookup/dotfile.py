# Personal workspace setup automation.
# @file Ansible lookup plugin for dotfiles.
# @author Rodrigo Siqueira <me@rodriados.com>
# @copyright 2026-present Rodrigo Siqueira
import os
from itertools import chain

from ansible.errors import AnsibleError
from ansible.plugins.lookup import LookupBase

class LookupModule(LookupBase):
    def run(self, terms, variables=None, **kwargs):
        self.set_options(var_options = variables, direct = kwargs)

        self.must_exist = kwargs('must_exist', False)
        self.avoid_local = kwargs('avoid_local', False)
        self.local_suffix = kwargs('local_suffix', '.local')
        self.search_path = map(os.path.expanduser, kwargs('search_path', ['~']))
        return list(self._search_dotfile_in_path(self.search_path, terms))

    def _search_dotfile_in_path(self, pathlist, targetlist):
        for path in pathlist:
            dotfiles   = [os.path.join(path, f) for f in targetlist]
            localfiles = [self._create_local_filename(f) for f in dotfiles]
            search_target_list = dotfiles if self.avoid_local else \
                chain.from_iterable(zip(localfiles, dotfiles))
            found = list(filter(os.path.exists, search_target_list))
            yield from (found if found or self.must_exist else dotfiles)

    def _create_local_filename(self, filename):
        return f"{filename}{self.local_suffix}"
