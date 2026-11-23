# Personal workspace setup automation.
# @file File helpers for Ansible filters.
# @author Rodrigo Siqueira <me@rodriados.com>
# @copyright 2026-present Rodrigo Siqueira
import os

def file_exist_or_last(filelist: list) -> str:
    """
    Returns the first existing file from a list of files.
    If none of the files exist, returns the last file in the list.
    @param filelist: List of file paths to check.
    @return: The first existing file or the last file in the list.
    """
    for file in filelist:
        if os.path.exists(file):
            return file
    return filelist[-1] if filelist else None

class FilterModule:
    """
    Ansible filter plugin for file helpers.
    """

    def filters(self) -> dict:
        return { 'file_exist_or_last': file_exist_or_last, }
