#!/usr/bin/env python

from setuptools import setup
from firelet import __version__

CLASSIFIERS = map(str.strip,
"""
Environment :: Console
License :: OSI Approved :: GNU General Public License (GPL)
Natural Language :: English
Operating System :: POSIX :: Linux
Programming Language :: Python
Topic :: Internet :: WWW/HTTP :: WSGI
""".splitlines())

setup(
    name="firelet",
    version = __version__,
    author = "Federico Ceratto",
    author_email = "federico.ceratto@gmail.com",
    description = "Distributed firewall management",
    license = "GPLv3+",
    url = "http://www.firelet.net/",
    long_description = """Firelet is a distributed firewall management tool. It provides a CLI and a web-based interface.""",
    classifiers=CLASSIFIERS,
    install_requires = [
        'bottle',
        'pygraphviz',
    ],
    packages = ["firelet"],
    platforms=['Linux'],
    package_data={'firelet': ['test/*',
                                                'views/*',
                                                'static/*']},
    entry_points = {
        'console_scripts': [
            'bpython = bpython.cli:main',
        ],
    },
    test_suite='nose.collector',
    tests_require=['nose'],
)

