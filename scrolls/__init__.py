"""Scrolls — a collection of skills for working with domain names."""

from pathlib import Path

try:
    from importlib.metadata import version

    __version__ = version("scrolls")
except Exception:
    __version__ = "0.1.0"


def skills_path() -> Path:
    """Return the path to the installed skills directory."""
    return Path(__file__).parent


def skill_path(name: str) -> Path:
    """Return the path to a specific skill's directory.

    Args:
        name: Skill name (e.g., "seer", "tome").

    Returns:
        Path to the skill directory.

    Raises:
        FileNotFoundError: If the skill does not exist.
    """
    path = skills_path() / name
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
    """
    path = skill_path(name) / filename
    if not path.is_file():
        raise FileNotFoundError(f"File '{filename}' not found in skill '{name}' at {path}")
    return path


def list_skills() -> list[str]:
    """Return the names of all available skills."""
    return sorted(
        p.name
        for p in skills_path().iterdir()
        if p.is_dir() and not p.name.startswith(("_", ".")) and (p / "SKILL.md").exists()
    )
