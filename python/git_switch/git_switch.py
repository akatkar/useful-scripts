from shutil import copyfile
from argparse import ArgumentParser
import json
import os
import subprocess


def read_accounts():
    with open("git_accounts.json") as git_accounts:
        a = json.load(git_accounts)
    return a


def exec_cmd(cmd):
    output = subprocess.Popen(cmd.split(),
                             stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)
    stdout, stderr = output.communicate()
    if stderr:
        print(stderr)
        exit(1)
    return stdout.decode().strip()


def show_accounts(accounts):
    for account in accounts:
        for key in account:
            print(f'{key} = {account[key]}')
        print()


def find_account_by_name(accounts, name):
    for account in accounts:
        if account['account'] == name:
            return account
    else:
        print(f'account {name} cannot be find')
        exit(1)


def show_current(accounts):
    username = exec_cmd('git config --global user.name')
    useremail = exec_cmd('git config --global user.email')

    for account in accounts:
        if account['user_name'] == username and account['user_email'] == useremail :
            print(f'Current config is [{account["account"]}]')
            break
    else:
        print("Git config is not specified with config file")
    print(f'user.name: {username}')
    print(f'user.email: {useremail}')
    print()


def switch_ssh_keys(account):
    ssh = os.path.expanduser('~/.ssh')
    private = os.path.join(ssh, f'{account["ssh_prefix"]}_id_rsa')
    public = os.path.join(ssh, f'{account["ssh_prefix"]}_id_rsa.pub')
    if os.path.isfile(private) and os.path.isfile(public):
        copyfile(private, os.path.join(ssh, 'id_rsa'))
        copyfile(public, os.path.join(ssh, 'id_rsa.pub'))
    else:
        print("shh keys cannot be found. Check prefix and key files")
        print(private)
        print(public)
        exit(1)
    print(f'Switched to {account["account"]}')

def switch_to(account):
    switch_ssh_keys(account)
    exec_cmd(f'git config --global user.name {account["user_name"]}')
    exec_cmd(f'git config --global user.email {account["user_email"]}')


def arguments():
    parser = ArgumentParser(description='Switch Git Accounts')

    group = parser.add_mutually_exclusive_group()
    group.add_argument('-c', '--current', action='store_true')
    group.add_argument('-l', '--list', action='store_true')
    group.add_argument('-s', '--switch')
    return parser.parse_args()

def main():
    args = arguments()
    accounts = read_accounts()
    if args.list:
        show_accounts(accounts)
    elif args.current:
        show_current(accounts)
    elif args.switch:
        new_account = find_account_by_name(accounts, args.switch)
        switch_to(new_account)
    else:
        show_current(accounts)


if __name__ == '__main__':
    main()


