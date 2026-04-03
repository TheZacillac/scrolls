"""Scrolls — a collection of skills for working with domain names."""

from pathlib import Path

try:
    from importlib.metadata import version, PackageNotFoundError

    __version__ = version("scrolls")
except PackageNotFoundError:
    __version__ = "0.1.0"


def skills_path() -> Path:
    """Return the path to the installed skills directory."""
    return Path(__file__).parent


def skill_path(name: str) -> Path:
    """Return the path to a specific skill's directory.

    Args:
        name: Skill name (e.g., "seer", "tome", "other/email-auth").

    Returns:
        Path to the skill directory.

    Raises:
        FileNotFoundError: If the skill does not exist.
        ValueError: If the skill name contains path traversal characters.
    """
    base = skills_path().resolve()
    path = (base / name).resolve()
    if not path.is_relative_to(base):
        raise ValueError(f"Invalid skill name: '{name}'")
    if not path.is_dir():
        raise FileNotFoundError(f"Skill '{name}' not found at {path}")
    return path


def skill_file(name: str, filename: str = "SKILL.md") -> Path:
    """Return the path to a specific file within a skill.

    Args:
        name: Skill name (e.g., "seer", "tome").
        filename: File to locate within the skill directory.

    Returns:
        Path to the file.

    Raises:
        FileNotFoundError: If the skill or file does not exist.
        ValueError: If the resolved path escapes the skill directory.
    """
    base = skill_path(name).resolve()
    path = (base / filename).resolve()
    if not path.is_relative_to(base):
        raise ValueError(f"filename '{filename}' escapes the skill directory")
    if not path.is_file():
        raise FileNotFoundError(f"File '{filename}' not found in skill '{name}' at {path}")
    return path


def list_skills() -> list[str]:
    """Return the names of all available skills, including nested namespace skills."""
    results = []
    base = skills_path()
    for p in base.iterdir():
        if not p.is_dir() or p.name.startswith(("_", ".")):
            continue
        if (p / "SKILL.md").exists():
            results.append(p.name)
        else:
            # One level of namespace containers (e.g., other/)
            for sub in p.iterdir():
                if (
                    sub.is_dir()
                    and not sub.name.startswith(("_", "."))
                    and (sub / "SKILL.md").exists()
                ):
                    results.append(f"{p.name}/{sub.name}")
    return sorted(results)
