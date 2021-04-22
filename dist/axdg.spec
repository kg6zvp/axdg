Name:           axdg
Version:        1.0
Release:        1%{?dist}
Summary:        Ada XDG Base Directory Specification Implementation

License:        MIT
URL:            https://github.com/kg6zvp/%{name}
Source0:        axdg-1.0.tar.gz

BuildRequires:  gcc-gnat fedora-gnat-project-common ahven gprbuild
# Build only on architectures where gcc-gnat is available:
ExclusiveArch:  %{GPRbuild_arches}

%global common_description_en \
Ada programming language implementation of the XDG Base Directory Specification

%global common_description_de \
XDG Basis Verzeichnis Vorschrift in Ada geschrieben

%description %{common_description_en}

blank

%description -l de %{common_description_de}

leer

%global debug_package %{nil}

%prep
%setup -c axdg-1.0

%build
gprclean axdg.gpr
gprbuild axdg.gpr

%install
%ifarch x86_64
	gprinstall -r --prefix=%{buildroot}/usr --lib-subdir=lib64 -p axdg.gpr
%else
	gprinstall -r --prefix=%{buildroot}/usr -p axdg.gpr
%endif

%files
%{_includedir}/%{name}
%{_libdir}/%{name}*
%{_GNAT_project_dir}/*

%changelog
* Sun Apr 18 2021 Sam <kg6zvp@gmail.com> - 1.0
- Created

